{
  config,
  pkgs,
  theme,
}:
{
  dunst = import ./services/dunst.nix {
    theme = theme;
    pkgs = pkgs;
  };
  kanshi = import ./services/kanshi.nix;
  network-manager-applet = import ./services/network-manager-applet.nix;
  nextcloud-client = import ./services/nextcloud-client.nix {
    config = config;
    pkgs = pkgs;
  };
  ssh-agent = import ./services/ssh-agent.nix;
}
