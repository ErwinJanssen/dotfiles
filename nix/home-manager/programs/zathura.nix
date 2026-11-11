{ theme, ... }:
{
  programs.zathura = {
    enable = true;
    options = {
      # Default background surrounding the document.
      default-bg = theme.dark.theme.dim.background;

      # The default text color of UI elements (status bar, etc.).
      default-fg = theme.dark.theme.normal.foreground;

      # the following GUI options to show:
      # s: status bar
      # v: vertical scrollbar
      # h: horizontal scrollbar
      guioptions = "svh";

      # Style the status bar.
      statusbar-bg = theme.dark.ui.status_bar.default.background;
      statusbar-fg = theme.dark.ui.status_bar.default.foreground;

      # Style the completion menu.
      completion-bg = theme.dark.ui.search.item.background;
      completion-fg = theme.dark.ui.search.default.foreground;
      completion-group-bg = theme.dark.ui.status_bar.active.background;
      completion-group-fg = theme.dark.ui.status_bar.active.foreground;
      completion-highlight-bg = theme.dark.ui.search.selected.background;
      completion-highlight-fg = theme.dark.ui.search.selected.foreground;

      # Default to dark mode document viewing using "recolor". Revert this by
      # running ":recolor false".
      recolor-darkcolor = theme.dark.theme.normal.foreground;
      recolor-lightcolor = theme.dark.theme.normal.background;
      recolor = true;

      # Increase the padding between pages to make page boundaries more clear.
      page-padding = 10;
    };
  };
}
