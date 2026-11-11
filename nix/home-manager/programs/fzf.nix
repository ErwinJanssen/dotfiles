{ theme, ... }:
{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    colors = {
      "fg+" = theme.dark.ui.search.selected.foreground;
      "bg+" = "-1";
      "hl+:" = theme.dark.ui.search.selected.match;
      bg = "-1";
      hl = theme.dark.ui.search.item.match;
      prompt = theme.dark.ui.search.input.foreground;
      pointer = theme.dark.ui.search.selected.foreground;
      marker = theme.dark.ui.search.selected.match;
    };
    defaultOptions = [ "--ansi" ];
    defaultCommand = "fd --type file --hidden --exclude .git --strip-cwd-prefix";
    fileWidget.command = "fd --unrestricted --exclude .git \\$dir";

    # Disable fzf history widget (CTRL-R binding) and let Atuin handle it
    historyWidget.command = "";
  };
}
