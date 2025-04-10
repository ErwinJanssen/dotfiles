{
  config,
  pkgs,
}:
{
  enable = true;
  package = config.lib.nixGL.wrap pkgs.wezterm;
  extraConfig = builtins.readFile ./extra_config.lua;
}
