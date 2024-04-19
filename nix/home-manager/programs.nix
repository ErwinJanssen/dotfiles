# Define program configurations, with a separate file per program. Pass the
# `theme` data to programs that need it.
{ theme }:
{
  # Let Home Manager install and manage itself.
  home-manager = import ./programs/home-manager.nix;

  readline = import ./programs/readline.nix;

  tmux = import ./programs/tmux/main.nix theme;
}
