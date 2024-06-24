{
  description = "Personal home configuration of Erwin Janssen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages = {
        erwin-theme = pkgs.stdenv.mkDerivation {
          name = "erwin-theme";
          src = ./.;

          buildInputs = [
            pkgs.gnumake
            (pkgs.python311.withPackages (python-pkgs: [ python-pkgs.colormath ]))
          ];

          buildPhase = ''
            make theme.json
          '';

          installPhase = ''
            mkdir -p $out
            cp theme.json $out/
          '';

        };

      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
      defaultPackage.${system} = home-manager.defaultPackage.${system};
      homeConfigurations."erwin" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./nix/home-manager/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          theme = builtins.fromJSON (builtins.readFile "${self.packages.erwin-theme}/theme.json");
        };
      };
    };
}
