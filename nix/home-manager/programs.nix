# Define program configurations, with a separate file per program. Pass the
# `theme` data to programs that need it.
{
  config,
  theme,
  pkgs,
}:
{
  # Let Home Manager install and manage itself.
  home-manager = import ./programs/home-manager.nix;

  # Shell setup
  bash = import ./programs/bash.nix;
  fish = import ./programs/fish/main.nix;
  kitty = import ./programs/kitty.nix {
    theme = theme.theme;
    pkgs = pkgs;
  };
  readline = import ./programs/readline.nix;
  starship = import ./programs/starship.nix;

  # CLI tools
  eza = import ./programs/eza.nix;
  fzf = import ./programs/fzf.nix theme;
  git = import ./programs/git.nix;
  ripgrep = import ./programs/ripgrep.nix;
  tmux = import ./programs/tmux/main.nix theme;
  neovim = import ./programs/neovim.nix;
  pyenv = import ./programs/pyenv.nix;

  # GUI programs
  firefox = import ./programs/firefox/main.nix theme;
  i3status = import ./programs/i3status.nix theme;
  rofi = import ./programs/rofi.nix {
    config = config;
    theme = theme.theme;
  };
  zathura = import ./programs/zathura.nix theme;
}
