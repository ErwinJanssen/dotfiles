{ theme, pkgs }:
{
  dunst = import ./services/dunst.nix {
    theme = theme.theme;
    pkgs = pkgs;
  };
  kanshi = import ./services/kanshi.nix;
  ssh-agent = import ./services/ssh-agent.nix;
}
