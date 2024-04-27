{
  config,
  pkgs,
  lib,
  theme,
}:
{
  windowManager = {
    sway = import ./wayland/sway/main.nix {
      config = config;
      pkgs = pkgs;
      lib = lib;
      theme = theme.theme;
    };
  };
}
