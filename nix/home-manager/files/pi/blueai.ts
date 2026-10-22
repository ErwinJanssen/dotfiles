// blueai.ts — BlueAI (BlueCode "new platform") provider extension for pi.
//
// WHY AN EXTENSION
// pi has no native discovery for the opencode `.well-known/opencode` protocol,
// and `models.json` is a static list. The BlueCode model catalog changes often,
// so the static list was rejected: `refreshModels` is pi's only dynamic
// mechanism. This extension is therefore a translator from the well-known
// format to `pi.registerProvider()`.
//
// DISCOVERY
//   1. GET /projects                (Bearer key)   -> inference projects
//   2. GET /projects/<id>/.well-known/opencode (public) -> provider config
//      with full model metadata and a per-project inference baseURL
//   3. Models are registered under ONE provider ("blueai") with per-model
//      `baseUrl` overrides, deduped by id across projects (first wins).
// The same well-known protocol exists on the old token-factory platform as a
// single public URL; the new platform scopes it per project, which is why the
// authenticated project-list hop is needed here.
//
// AUTH
// pi-native: /login on this provider shows the fabricated "Enter API key"
// prompt; the credential is stored in ~/.pi/agent/auth.json and preferred over
// everything else. Fallback: $BLUECODE_API_KEY. Discovery reuses the stored
// credential via refreshModels' context. Base URL override: $BLUECODE_API_URL.
//
// THINKING LEVELS
// `off` maps to reasoning_effort "low": on this backend, effort "none" makes
// GLM models narrate their reasoning into the `content` channel, while "low"
// disables thinking cleanly (0 reasoning tokens, clean content channel).
// Well-known `variants` supply the remaining levels; `disabled` or
// unadvertised levels are hidden (null) from pi's thinking controls.
//
// COMPAT FLAGS (required protocol behavior of this backend family)
// supportsDeveloperRole=false, maxTokensField="max_tokens",
// supportsReasoningEffort=true on reasoning models.
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const PROVIDER_ID = "blueai";
const BASE = (process.env.BLUECODE_API_URL ?? "https://bluecode.ai.team.blue").replace(/\/+$/, "");
const REQUEST_TIMEOUT_MS = 10_000;

interface WellKnownModel {
  name?: string;
  reasoning?: boolean;
  limit?: { context?: number; output?: number };
  cost?: { input?: number; output?: number; cache_read?: number };
  modalities?: { input?: string[] } | null;
  capabilities?: { input?: { image?: boolean } };
  variants?: Record<string, { reasoningEffort?: string; disabled?: boolean }>;
}

interface WellKnownProvider {
  name?: string;
  options?: { baseURL?: string };
  models?: Record<string, WellKnownModel>;
}

interface Project {
  id: number;
  type?: string;
}

interface RefreshContext {
  allowNetwork: boolean;
  signal?: AbortSignal;
  credential?: { type?: string; key?: string };
  stored?: { models?: Record<string, unknown>[] };
  publish(publication: unknown): Promise<boolean>;
}

type ModelConfig = Record<string, unknown>;

function buildThinkingLevelMap(m: WellKnownModel): Record<string, string | null> | undefined {
  if (m.reasoning !== true) return undefined;
  const map: Record<string, string | null> = { off: "low" };
  const variants = m.variants ?? {};
  for (const level of ["minimal", "low", "medium", "high", "xhigh", "max"]) {
    const v = variants[level];
    map[level] = v && !v.disabled && typeof v.reasoningEffort === "string" ? v.reasoningEffort : null;
  }
  return map;
}

function isImageCapable(m: WellKnownModel): boolean {
  return m.modalities?.input?.includes("image") === true || m.capabilities?.input?.image === true;
}

async function getJson(url: string, key: string | undefined, signal?: AbortSignal): Promise<any> {
  const headers: Record<string, string> = {};
  if (key) headers.Authorization = `Bearer ${key}`;
  const res = await fetch(url, {
    headers,
    signal: AbortSignal.any([signal ?? new AbortController().signal, AbortSignal.timeout(REQUEST_TIMEOUT_MS)]),
  });
  if (!res.ok) throw new Error(`${url} -> HTTP ${res.status}`);
  return res.json();
}

function mapModels(providerDef: WellKnownProvider): ModelConfig[] {
  const baseURL = providerDef.options?.baseURL;
  return Object.entries(providerDef.models ?? {}).map(([id, m]) => {
    const reasoning = m.reasoning === true;
    return {
      id,
      name: m.name ?? id,
      reasoning,
      thinkingLevelMap: buildThinkingLevelMap(m),
      input: isImageCapable(m) ? ["text", "image"] : ["text"],
      contextWindow: m.limit?.context ?? 128_000,
      maxTokens: m.limit?.output ?? 16_384,
      cost: {
        input: m.cost?.input ?? 0,
        output: m.cost?.output ?? 0,
        cacheRead: m.cost?.cache_read ?? 0,
        cacheWrite: 0,
      },
      compat: {
        supportsDeveloperRole: false,
        supportsReasoningEffort: reasoning,
        maxTokensField: "max_tokens" as const,
      },
      ...(baseURL ? { baseUrl: baseURL } : {}),
    };
  });
}

export default function (pi: ExtensionAPI) {
  pi.registerProvider(PROVIDER_ID, {
    name: "BlueAI (BlueCode)",
    baseUrl: BASE,
    api: "openai-completions",
    async refreshModels(context: RefreshContext) {
      const restore = (): ModelConfig[] => (context.stored?.models ?? []) as ModelConfig[];
      if (!context.allowNetwork || context.signal?.aborted) return restore();
      const key = context.credential?.type === "api_key" ? context.credential.key : process.env.BLUECODE_API_KEY;
      if (!key) return restore();

      try {
        const list: Project[] = (await getJson(`${BASE}/projects`, key, context.signal)).projects ?? [];
        const inference = list.filter((p) => p.type === "inference");
        const seen = new Set<string>();
        const models: ModelConfig[] = [];
        for (const project of inference) {
          try {
            const wk = await getJson(`${BASE}/projects/${project.id}/.well-known/opencode`, undefined, context.signal);
            const providers = Object.values(wk?.config?.provider ?? {}) as WellKnownProvider[];
            for (const def of providers) {
              for (const model of mapModels(def)) {
                const id = model.id as string;
                if (!seen.has(id)) {
                  seen.add(id);
                  models.push(model);
                }
              }
            }
          } catch (err) {
            console.warn(`[blueai] project ${project.id}: ${err}`);
          }
        }
        if (models.length === 0 && context.stored) return restore();
        try {
          await context.publish({ persist: { models, checkedAt: Date.now() } });
        } catch (err) {
          console.warn(`[blueai] persist failed: ${err}`);
        }
        return models;
      } catch (err) {
        console.warn(`[blueai] discovery failed, keeping previous list: ${err}`);
        return restore();
      }
    },
  });
}
