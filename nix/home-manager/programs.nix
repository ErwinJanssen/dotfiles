# Define program configurations, with a separate file per program. Pass the
# `theme` data to programs that need it.
{ config, theme }:
{
  # Let Home Manager install and manage itself.
  home-manager = import ./programs/home-manager.nix;

  # Shell setup
  fish = import ./programs/fish.nix;
  readline = import ./programs/readline.nix;

  # CLI tools
  fzf = import ./programs/fzf.nix theme;
  git = import ./programs/git.nix;
  ripgrep = import ./programs/ripgrep.nix;
  tmux = import ./programs/tmux/main.nix theme;

  # GUI programs
  i3status = import ./programs/i3status.nix theme;
  rofi = import ./programs/rofi.nix {
    config = config;
    theme = theme.theme;
  };
}
