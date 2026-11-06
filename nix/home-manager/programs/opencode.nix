{
  programs.opencode = {
    enable = true;
    settings = {
      plugin = [ "@mohak34/opencode-notifier@latest" ];
    };

    # Instructions for Git commit message conventions
    context = builtins.readFile ../files/AGENTS.md;
  };
}
