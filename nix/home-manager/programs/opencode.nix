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
    context = ''
      ## Git commit conventions

      ### General

      1. Subject line: <=50 characters
      2. Use Markdown, especially backticks for variables and code

      ### AI transparency

      You MUST include `Assisted-by` trailers for each AI model that assisted
      with the work. Use the format `opencode:MODEL` where MODEL is the
      identifier of the model being used.

      Example: Assisted-by: opencode:mistral-medium-3.5
    '';
  };
}
