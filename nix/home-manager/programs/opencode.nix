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
    };

    # Instructions for Git commit message conventions
    context = ''
      ## Git commit conventions

      When creating Git commits, you MUST include `Assisted-by` trailers for
      each AI model that assisted with the work.

      ### Format

      - Single model: `Assisted-by: opencode:MODEL`.
      - Multiple models: Add multiple `Assisted-by` lines, one per model.

      ### Rules

      1. Place `Assisted-by` trailers at the end of the commit message, after
         the body.
      2. Use the format `opencode:MODEL` where MODEL is the identifier of the
         model being used.
      3. Include one line per assisting AI model.

      ### Example

      ```
      Feat: Add new configuration

      Add support for feature X

      Assisted-by: opencode:mistral-medium-3.5
      ```
    '';
  };
}
