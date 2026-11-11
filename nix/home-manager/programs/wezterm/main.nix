{
  config,
  pkgs,
  theme,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.wezterm;
    extraConfig = builtins.readFile ./extra_config.lua;
    colorSchemes = {
      custom = {
        ansi = [
          theme.dark.colors.normal.black
          theme.dark.colors.normal.red
          theme.dark.colors.normal.green
          theme.dark.colors.normal.yellow
          theme.dark.colors.normal.blue
          theme.dark.colors.normal.magenta
          theme.dark.colors.normal.cyan
          theme.dark.colors.normal.white
        ];
        brights = [
          theme.dark.colors.bright.black
          theme.dark.colors.bright.red
          theme.dark.colors.bright.green
          theme.dark.colors.bright.yellow
          theme.dark.colors.bright.blue
          theme.dark.colors.bright.magenta
          theme.dark.colors.bright.cyan
          theme.dark.colors.bright.white
        ];
        background = theme.dark.theme.normal.background;
        foreground = theme.dark.theme.normal.foreground;

        # Cursor 'background' is actually the color of the cursor beam.
        cursor_bg = theme.dark.theme.normal.foreground;
        cursor_border = theme.dark.theme.normal.foreground;
      };
    };
  };
}
