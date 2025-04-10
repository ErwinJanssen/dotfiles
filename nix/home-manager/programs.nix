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
    theme = theme;
    pkgs = pkgs;
  };
  readline = import ./programs/readline.nix;
  starship = import ./programs/starship.nix;

  # CLI tools
  eza = import ./programs/eza.nix;
  fd = import ./programs/fd.nix;
  fzf = import ./programs/fzf.nix { theme = theme; };
  git = import ./programs/git.nix;
  ripgrep = import ./programs/ripgrep.nix;
  tmux = import ./programs/tmux/main.nix { theme = theme; };
  neovim = import ./programs/neovim/main.nix { pkgs = pkgs; };
  ssh = import ./programs/ssh.nix;

  # GUI programs
  firefox = import ./programs/firefox/main.nix {
    config = config;
    pkgs = pkgs;
    theme = theme;
  };
  rofi = import ./programs/rofi.nix {
    config = config;
    theme = theme;
  };
  swaylock = import ./programs/swaylock.nix {
    pkgs = pkgs;
    theme = theme;
  };
  thunderbird = import ./programs/thunderbird.nix {
    config = config;
    pkgs = pkgs;
  };
  waybar = import ./programs/waybar/main.nix { theme = theme; };
  wezterm = import ./programs/wezterm/main.nix {
    config = config;
    pkgs = pkgs;
    theme = theme;
  };
  zathura = import ./programs/zathura.nix { theme = theme; };
}
