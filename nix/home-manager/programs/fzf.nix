{ theme }:
{
  enable = true;
  enableFishIntegration = true;
  colors = {
    "fg+" = theme.ui.search.selected.foreground;
    "bg+" = "-1";
    "hl+:" = theme.ui.search.selected.match;
    bg = "-1";
    hl = theme.ui.search.item.match;
    prompt = theme.ui.search.input.foreground;
    pointer = theme.ui.search.selected.foreground;
    marker = theme.ui.search.selected.match;
  };
  defaultOptions = [ "--ansi" ];
  defaultCommand = "fd --type file --hidden --exclude .git --strip-cwd-prefix";
  fileWidgetCommand = "command fd --unrestricted --search-path $dir --exclude .git";
}
