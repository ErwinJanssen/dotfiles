{
  enable = true;

  # Do not install Sway via Nix, but use the system version. Sway integrates
  # with the system, so installing it purely via Nix on non-NixOS can cause
  # problems, like with missing drivers.
  package = null;
}
