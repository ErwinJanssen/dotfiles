{
  config,
  pkgs,
  theme,
}:
{
  ollama = import ./services/ollama.nix;
  ssh-agent = import ./services/ssh-agent.nix;
  gpg-agent = import ./services/gpg-agent.nix { pkgs = pkgs; };
}
