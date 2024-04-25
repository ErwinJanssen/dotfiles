{ config, lib }:
{
  windowManager = {
    sway = import ./wayland/sway/main.nix {
      config = config;
      lib = lib;
    };
  };
}
