{
  config,
  theme,
  pkgs,
}:
{
  enable = true;
  package = config.lib.nixGL.wrap pkgs.kitty;
  font = {
    name = "Monospace";
    size = 12.0;
  };
  settings = {
    # Increase the space between lines
    adjust_line_height = "110%";

    # Disable ligatures if the cursor is on them
    disable_ligatures = "cursor";

    # Use a single line cursor instead of a block, to make it easier to see
    # where it is located exactly.
    cursor_shape = "beam";

    # Disable sounds
    enable_audio_bell = "no";

    # Colors
    foreground = theme.theme.normal.foreground;
    background = theme.theme.normal.background;

    color0 = theme.colors.normal.black;
    color1 = theme.colors.normal.red;
    color2 = theme.colors.normal.green;
    color3 = theme.colors.normal.yellow;
    color4 = theme.colors.normal.blue;
    color5 = theme.colors.normal.magenta;
    color6 = theme.colors.normal.cyan;
    color7 = theme.colors.normal.white;

    color8 = theme.colors.bright.black;
    color9 = theme.colors.bright.red;
    color10 = theme.colors.bright.green;
    color11 = theme.colors.bright.yellow;
    color12 = theme.colors.bright.blue;
    color13 = theme.colors.bright.magenta;
    color14 = theme.colors.bright.cyan;
    color15 = theme.colors.bright.white;
  };
}
