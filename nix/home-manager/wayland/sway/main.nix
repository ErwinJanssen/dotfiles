{
  config,
  pkgs,
  lib,
  theme,
}:
let
  mod = config.wayland.windowManager.sway.config.modifier;
in
{
  enable = true;

  # Do not install Sway via Nix, but use the system version. Sway integrates
  # with the system, so installing it purely via Nix on non-NixOS can cause
  # problems, like with missing drivers.
  package = null;

  config = {
    # Use 'logo' key as default modifier.
    modifier = "Mod4";

    # Use system installed Kitty as default terminal.
    terminal = "kitty";

    # Use Rofi as application launcher.
    menu = "rofi -show run";

    # Append custom keybindings to the default config.
    keybindings = lib.mkOptionDefault {
      # Add bindings for wokspace 10. As of NixOS 23.11, the default Sway
      # config from Home Manager includes keybinding for workspaces up to 9.
      "${mod}+0" = "workspace number 10";
      "${mod}+Shift+0" = "move container to workspace number 10";
    };

    output = {
      "*" = {
        bg = "/usr/share/backgrounds/default.png fill";
      };
    };

    bars = [
      {
        # Use i3status as status command.
        statusCommand = "${pkgs.i3status}/bin/i3status";

        # Bar should be permanently visible at the top edge of the screen.
        mode = "dock";
        position = "top";

        fonts = {
          # Use the default monospace font as configured via Fontconfig.
          names = [ "Monospace" ];
          size = 10.0;
        };

        # Use colors from theme.
        colors = {
          statusline = theme.ui.status_bar.default.foreground;
          background = theme.ui.status_bar.default.background;
          focusedWorkspace = {
            background = theme.ui.status_bar.active.background;
            border = theme.ui.status_bar.active.background;
            text = theme.ui.status_bar.active.foreground;
          };
          inactiveWorkspace = {
            background = theme.ui.status_bar.tab.background;
            border = theme.ui.status_bar.tab.background;
            text = theme.ui.status_bar.tab.foreground;
          };
          urgentWorkspace = {
            background = theme.ui.status_bar.urgent.background;
            border = theme.ui.status_bar.urgent.background;
            text = theme.ui.status_bar.urgent.foreground;
          };
        };
      }
    ];
  };

  extraConfigEarly = ''
    set $mod ${mod}
  '';
  extraConfig = builtins.readFile ./extra.conf;
}
