{ config, pkgs, ... }:
{
  # Install the pre-push hook that refuses to push unsigned commits authored
  # by the configured user. All repositories use it through core.hooksPath.
  home.file.".config/git/hooks/pre-push" = {
    source = ./pre-push;
    executable = true;
  };

  # Run the pre-commit hooks from .pre-commit-config.yaml on every commit
  # in every repository, using the same entry point as the shim that
  # `pre-commit install` generates. The pre-commit store path is
  # interpolated by Home Manager, so the hook stays current without
  # re-running `pre-commit install` in each repository.
  home.file.".config/git/hooks/pre-commit" = {
    text = ''
      #!/bin/sh
      # PRE_COMMIT_ALLOW_NO_CONFIG skips repositories that have no
      # .pre-commit-config.yaml instead of blocking their commits.
      set -eu

      PRE_COMMIT_ALLOW_NO_CONFIG=1 exec ${pkgs.pre-commit}/bin/pre-commit \
        hook-impl --config=.pre-commit-config.yaml --hook-type=pre-commit
    '';
    executable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Erwin Janssen";
        email = "code@erwinjanssen.nl";
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        # Run the hooks from ~/.config/git/hooks in every repository.
        hooksPath = "${config.home.homeDirectory}/.config/git/hooks";

        # Explicitly use the SSH config found in the home directory.
        # This prevents SSH from using the system wide configuration,
        # which makes it more reproducible across devices.
        sshCommand = "ssh -F ~/.ssh/config";
      };
      fetch = {
        # Delete local remote-tracking branches that were deleted upstream.
        prune = true;
      };
      push = {
        # Set the upstream automatically when pushing a branch that does not
        # have one yet. Existing upstreams are never changed.
        autoSetupRemote = true;
      };
      rerere = {
        # Record conflict resolutions and replay them when the same conflict
        # recurs, e.g. when rebasing a long-lived branch repeatedly.
        enabled = true;
      };
      commit = {
        gpgSign = true;
      };
      signing = {
        key = "8C066B7189E4DF0E";
        signByDefault = true;
      };
    };
    ignores = [
      ".arborinth/"
      ".opencode/"
    ];
    includes = [
      {
        # Automatically use correct email address for work repos.
        condition = "gitdir:~/workspace/team.blue/";
        contents = {
          user = {
            email = "erwin.janssen@team.blue";
          };
        };
      }

    ];
  };
}
