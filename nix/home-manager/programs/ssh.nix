{
  enable = true;
  includes = [ "~/.ssh/config.d/*.conf" ];

  # Disable default config as these values are not required. This suppresses
  # the warning "`programs.ssh` default values will be removed in the future".
  enableDefaultConfig = false;
}
