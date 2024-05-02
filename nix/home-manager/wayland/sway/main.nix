{
  config,
  pkgs,
  lib,
  theme,
}:
let
  mod = config.wayland.windowManager.sway.config.modifier;
  menu = config.wayland.windowManager.sway.config.menu;
  term = config.wayland.windowManager.sway.config.terminal;

  notification-command = ''
    ${pkgs.libnotify}/bin/notify-send \
    --transient \
    --expire-time=1000'';

  volume-notification-command = ''
    VALUE=$(pactl get-sink-volume @DEFAULT_SINK@) \
      && VALUE=$${VALUE%%%*} && VALUE=$${VALUE##* } \
      && ${notification-command} \
        --hint=string:x-canonical-private-synchronous:volume \
        --hint="int:value:$VALUE" \
        "Volume: $${VALUE}%"'';

  volume-mute-notification-command = ''
    MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@) \
      && ICON=$${MUTE_STATUS/*no/audio-volume-high-symbolic} \
      && ICON=$${ICON/*yes/audio-volume-muted-symbolic} \
      && ${notification-command} --icon="$ICON" "$MUTE_STATUS"
  '';

  brightness-notification-command = ''
    VALUE=$(brightnessctl get --percentage) && ${notification-command} \
      --hint=string:x-canonical-private-synchronous:brightness \
      --hint="int:value:$VALUE" \
      "Brightness: $${VALUE}%"'';
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

    focus = {
      # Do not let the mouse position determine which window has the focus.
      followMouse = false;
    };

    input = {
      "type:touchpad" = {
        # Enable 'tab to click'.
        tap = "enabled";
      };

      "type:keyboard" = {
        # Map `CapsLock` to `Escape`.
        xkb_options = "caps:escape";
      };
    };

    # Append custom keybindings to the default config.
    keybindings = lib.mkOptionDefault {
      # Add bindings for wokspace 10. As of NixOS 23.11, the default Sway
      # config from Home Manager includes keybinding for workspaces up to 9.
      "${mod}+0" = "workspace number 10";
      "${mod}+Shift+0" = "move container to workspace number 10";

      # Tap the left Super key to start the launcher, instead of `$mod+d`.
      "--release Super_L" = "exec ${menu}";
      "${mod}+d" = null;

      # Switch back and forth the current and the previous window, similar to
      # how alt-tab works in other window managers.
      "${mod}+tab" = "workspace back_and_forth";

      # Keybinding to lock the screen.
      "${mod}+l" = "exec swaylock";

      # Increase/decrease/mute audio volume, also when screen is locked.
      "--locked XF86AudioRaiseVolume" = ''
        exec pactl set-sink-volume @DEFAULT_SINK@ +2% \
          && ${volume-notification-command} \
            --icon=audio-volume-high-symbolic
      '';
      "--locked XF86AudioLowerVolume" = ''
        exec pactl set-sink-volume @DEFAULT_SINK@ -2% \
          && ${volume-notification-command} \
            --icon=audio-volume-low-symbolic
      '';
      "--locked XF86AudioMute" = ''
        exec pactl set-sink-mute @DEFAULT_SINK@ toggle \
          && ${volume-mute-notification-command}
      '';

      # Increase/decrease screen brightness.
      XF86MonBrightnessUp = ''
        exec brightnessctl set 5%+ && ${brightness-notification-command} \
          --icon=display-brightness-high-symbolic
      '';
      XF86MonBrightnessDown = ''
        exec brightnessctl set 5%- && ${brightness-notification-command} \
          --icon=display-brightness-low-symbolic
      '';
    };

    output = {
      "*" = {
        bg = "wallpaper.jpg fill";
      };
    };

    startup = [
      # Start a terminal with a tmux sessions. This will be moved to the
      # scratchpad automatically.
      { command = "${term} --class terminal_scratchpad -e tmux new-session -A -s scratch"; }

      # Always restart Kanshi, also after reloading the config, to apply output
      # settings.
      {
        command = "systemctl --user restart kanshi.service";
        always = true;
      }
    ];

    window = {
      # Default window border is 2 pixels.
      border = 2;

      # Hide titlebar by default for tiled windows.
      titlebar = false;

      # Hides window borders adjacent to the screen edges
      hideEdgeBorders = "smart";

      commands = [
        # Automatically move the 'scratchpad' terminal to the scratchpad.
        {
          criteria = {
            app_id = "terminal_scratchpad";
          };
          command = "move scratchpad";
        }
      ];
    };

    # Styling for window borders and title bars.
    colors = {
      focused = {
        border = theme.ui.status_bar.active.background;
        background = theme.ui.status_bar.active.background;
        text = theme.ui.status_bar.active.foreground;
        indicator = theme.theme.normal.accent;
        childBorder = theme.theme.dim.accent;
      };
      unfocused = {
        border = theme.ui.status_bar.tab.background;
        background = theme.ui.status_bar.tab.background;
        text = theme.ui.status_bar.default.foreground;
        indicator = theme.ui.status_bar.default.background;
        childBorder = theme.ui.status_bar.default.background;
      };
      urgent = {
        border = theme.theme.normal.urgent;
        background = theme.theme.normal.urgent;
        text = theme.theme.normal.foreground;
        indicator = theme.theme.normal.accent;
        childBorder = theme.theme.dim.accent;
      };
    };

    bars = [ ];
  };

  extraConfigEarly = ''
    set $mod ${mod}
  '';
  extraConfig = builtins.readFile ./extra.conf;
}
