{ pkgs }:
{
  enable = true;
  # Listing extensions here will only enable them, they will not be installed
  # so that has to be done manually. This is probably because GNOME itself is
  # not being installed and managed by Home Manager.
  extensions = [
    { package = pkgs.gnomeExtensions.ddterm; }
  ];
}
