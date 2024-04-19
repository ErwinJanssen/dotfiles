# Define program configurations, with a separate file per program. Pass the
# `theme` data to programs that need it.
{ config, theme }:
{
  # Let Home Manager install and manage itself.
  home-manager = import ./programs/home-manager.nix;

  readline = import ./programs/readline.nix;

  fzf = import ./programs/fzf.nix theme;
  tmux = import ./programs/tmux/main.nix theme;

  # GUI programs
  i3status = import ./programs/i3status.nix theme;
  rofi = import ./programs/rofi.nix {
    config = config;
    theme = theme.theme;
  };
}
