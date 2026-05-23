# Define program configurations, with a separate file per program. Pass the
# `theme` data to programs that need it.
{
  config,
  theme,
  pkgs,
  ...
}:
{
  imports = [
    # Let Home Manager install and manage itself.
    ./programs/home-manager.nix

    # Shell setup
    ./programs/bash.nix
    ./programs/fish/main.nix
    ./programs/kitty.nix
    ./programs/readline.nix
    ./programs/starship.nix

    # CLI tools
    ./programs/atuin.nix
    ./programs/delta.nix
    ./programs/eza.nix
    ./programs/fd.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/ripgrep.nix
    ./programs/tmux/main.nix
    ./programs/neovim/main.nix
    ./programs/ssh.nix
    ./programs/zellij.nix

    # GUI programs
    ./programs/firefox/main.nix
    ./programs/gnome-shell.nix
    ./programs/thunderbird.nix
    ./programs/wezterm/main.nix
    ./programs/zathura.nix
  ];
}
