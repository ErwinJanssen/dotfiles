# Define program configurations, with a separate file per program.
{
  # Let Home Manager install and manage itself.
  home-manager = import ./programs/home-manager.nix;
}
