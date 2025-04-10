{
  config,
  pkgs,
}:
{
  enable = true;
  package = config.lib.nixGL.wrap pkgs.wezterm;
}
