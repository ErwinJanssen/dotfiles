{
  config,
  pkgs,
  theme,
}:
{
  enable = true;
  package = config.lib.nixGL.wrap pkgs.wezterm;
  extraConfig = builtins.readFile ./extra_config.lua;
  colorSchemes = {
    custom = {
      ansi = [
        theme.colors.normal.black
        theme.colors.normal.red
        theme.colors.normal.green
        theme.colors.normal.yellow
        theme.colors.normal.blue
        theme.colors.normal.magenta
        theme.colors.normal.cyan
        theme.colors.normal.white
      ];
      brights = [
        theme.colors.bright.black
        theme.colors.bright.red
        theme.colors.bright.green
        theme.colors.bright.yellow
        theme.colors.bright.blue
        theme.colors.bright.magenta
        theme.colors.bright.cyan
        theme.colors.bright.white
      ];
      background = theme.theme.normal.background;
      foreground = theme.theme.normal.foreground;

      # Cursor 'background' is actually the color of the cursor beam.
      cursor_bg = theme.theme.normal.foreground;
      cursor_border = theme.theme.normal.foreground;
    };
  };
}
