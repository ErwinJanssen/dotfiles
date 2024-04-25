{ config, lib }:
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
  };

  extraConfigEarly = ''
    set $mod ${mod}
  '';
  extraConfig = ''
    include '$(/usr/libexec/sway/layered-include "/usr/share/sway/config.d/*.conf" "/etc/sway/config.d/*.conf" "$XDG_CONFIG_HOME/sway/config.d/*.conf")'
  '';
}
