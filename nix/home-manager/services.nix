{ theme }:
{
  dunst = import ./services/dunst.nix theme;
  ssh-agent = import ./services/ssh-agent.nix;
}
