{ pkgs, theme }:
{
  enable = true;

  # Disable the delay when hitting escape, since this also has an effect on
  # applications such as Vim.
  escapeTime = 0;

  # Enable mouse support.
  mouse = true;

  # Use Fish from nixpkgs as the default shell when starting tmux.
  shell = "${pkgs.fish}/bin/fish";

  # Read extra configuration for templates `tmux.conf`.
  extraConfig = import ./tmux.conf { theme = theme; };
}
