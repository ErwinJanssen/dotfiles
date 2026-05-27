{
  config,
  theme,
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    font = {
      name = "Monospace";
      size = 12.0;
    };
    settings = {
      # Use Fish from nixpkgs as the default shell when starting Kitty.
      shell = "${pkgs.fish}/bin/fish";

      # Increase the space between lines
      adjust_line_height = "110%";

      # Disable ligatures if the cursor is on them
      disable_ligatures = "cursor";

      # Use a single line cursor instead of a block, to make it easier to see
      # where it is located exactly.
      cursor_shape = "beam";

      # Disable sounds
      enable_audio_bell = "no";
    };
  };
  # Dark theme colors
  home.file.".config/kitty/dark-theme.auto.conf".text = ''
    foreground ${theme.dark.theme.normal.foreground}
    background ${theme.dark.theme.normal.background}

    color0 ${theme.dark.colors.normal.black}
    color1 ${theme.dark.colors.normal.red}
    color2 ${theme.dark.colors.normal.green}
    color3 ${theme.dark.colors.normal.yellow}
    color4 ${theme.dark.colors.normal.blue}
    color5 ${theme.dark.colors.normal.magenta}
    color6 ${theme.dark.colors.normal.cyan}
    color7 ${theme.dark.colors.normal.white}

    color8 ${theme.dark.colors.bright.black}
    color9 ${theme.dark.colors.bright.red}
    color10 ${theme.dark.colors.bright.green}
    color11 ${theme.dark.colors.bright.yellow}
    color12 ${theme.dark.colors.bright.blue}
    color13 ${theme.dark.colors.bright.magenta}
    color14 ${theme.dark.colors.bright.cyan}
    color15 ${theme.dark.colors.bright.white}
  '';
  # Light theme colors
  #
  # The foreground and background colors are swapped compared to the dark theme,
  # as a quick and simple way to get a light theme. The other colors are the
  # same for now but these will change in the future.
  home.file.".config/kitty/no-preference-theme.auto.conf".text = ''
    foreground ${theme.light.theme.normal.background}
    background ${theme.light.theme.normal.foreground}

    color0 ${theme.light.colors.normal.black}
    color1 ${theme.light.colors.normal.red}
    color2 ${theme.light.colors.normal.green}
    color3 ${theme.light.colors.normal.yellow}
    color4 ${theme.light.colors.normal.blue}
    color5 ${theme.light.colors.normal.magenta}
    color6 ${theme.light.colors.normal.cyan}
    color7 ${theme.light.colors.normal.white}

    color8 ${theme.light.colors.bright.black}
    color9 ${theme.light.colors.bright.red}
    color10 ${theme.light.colors.bright.green}
    color11 ${theme.light.colors.bright.yellow}
    color12 ${theme.light.colors.bright.blue}
    color13 ${theme.light.colors.bright.magenta}
    color14 ${theme.light.colors.bright.cyan}
    color15 ${theme.light.colors.bright.white}
  '';
}
