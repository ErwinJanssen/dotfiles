{theme}: {
  enable = true;
  settings = {
    theme = "custom";
    themes = {
      custom = {
        fg = theme.theme.normal.foreground;
        bg = theme.theme.normal.background;
        black = theme.colors.normal.black;
        red = theme.colors.normal.red;
        green = theme.colors.normal.green;
        yellow = theme.colors.normal.yellow;
        blue = theme.colors.normal.blue;
        magenta = theme.colors.normal.magenta;
        cyan = theme.colors.normal.cyan;
        white = theme.colors.normal.white;
        # Manual mix of red and yellow.
        orange = "#d29375";
      };
    };
  };
}
