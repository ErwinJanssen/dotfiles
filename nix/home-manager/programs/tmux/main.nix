{ theme }:
{
  enable = true;

  # Disable the delay when hitting escape, since this also has an effect on
  # applications such as Vim.
  escapeTime = 0;

  # Enable mouse support.
  mouse = true;

  # Read extra configuration for templates `tmux.conf`.
  extraConfig = import ./tmux.conf { theme = theme; };
}
