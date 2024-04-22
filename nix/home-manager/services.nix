{ theme }:
{
  mako = import ./services/mako.nix theme;
  ssh-agent = import ./services/ssh-agent.nix;
}
