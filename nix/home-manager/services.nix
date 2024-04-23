{ theme }:
{
  dunst = import ./services/dunst.nix theme;
  kanshi = import ./services/kanshi.nix;
  ssh-agent = import ./services/ssh-agent.nix;
}
