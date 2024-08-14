{ theme, pkgs }:
{
  dunst = import ./services/dunst.nix {
    theme = theme;
    pkgs = pkgs;
  };
  kanshi = import ./services/kanshi.nix;
  network-manager-applet = import ./services/network-manager-applet.nix;
  ssh-agent = import ./services/ssh-agent.nix;
}
