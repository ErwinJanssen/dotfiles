{
  programs.opencode = {
    enable = true;
    settings = {
      provider = {
        # Configure username for the BlueAI provider, the authentication is in
        # `~/.local/share/opencode/auth.json`.
        #
        # Additional configuration is automatically loaded from the upsteam
        # `.well-known/opencode`.
        blueai = {
          options = {
            headers = {
              x-bluecode-user = "erwin.janssen@team.blue";
              x-token-factory-user = "erwin.janssen@team.blue";
              x-client-app-id = "opencode";
            };
          };
        };
      };
      plugin = [ "@mohak34/opencode-notifier@latest" ];
    };

    # Instructions for Git commit message conventions
    context = builtins.readFile ../files/AGENTS.md;
  };
}
