{ theme }:
{
  enable = true;
  options = {
    # Default background surrounding the document.
    default-bg = theme.theme.dim.background;

    # The default text color of UI elements (status bar, etc.).
    default-fg = theme.theme.normal.foreground;

    # the following GUI options to show:
    # s: status bar
    # v: vertical scrollbar
    # h: horizontal scrollbar
    guioptions = "svh";

    # Style the status bar.
    statusbar-bg = theme.ui.status_bar.default.background;
    statusbar-fg = theme.ui.status_bar.default.foreground;

    # Style the completion menu.
    completion-bg = theme.ui.search.item.background;
    completion-fg = theme.ui.search.default.foreground;
    completion-group-bg = theme.ui.status_bar.active.background;
    completion-group-fg = theme.ui.status_bar.active.foreground;
    completion-highlight-bg = theme.ui.search.selected.background;
    completion-highlight-fg = theme.ui.search.selected.foreground;

    # Default to dark mode document viewing using "recolor". Revert this by
    # running ":recolor false".
    recolor-darkcolor = theme.theme.normal.foreground;
    recolor-lightcolor = theme.theme.normal.background;
    recolor = true;

    # Increase the padding between pages to make page boundaries more clear.
    page-padding = 10;
  };
}
