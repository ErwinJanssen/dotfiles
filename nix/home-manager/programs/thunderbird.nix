{
  config,
  pkgs,
}:
{
  enable = true;
  package = config.lib.nixGL.wrap pkgs.thunderbird;
  profiles = {
    default = {
      isDefault = true;
    };
  };
}
