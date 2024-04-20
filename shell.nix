let
  # Pin of nixpkgs-unstable
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/92d295f588631b0db2da509f381b4fb1e74173c5.tar.gz";

  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    # To format Nix code.
    nixfmt-rfc-style
  ];
}
