{
  description = "Personal home configuration of Erwin Janssen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixgl,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      defaultPackage.${system} = home-manager.defaultPackage.${system};

      packages = {
        # Define a package for the theme data, in order to pass that to
        # `home.nix`. This is needed, because Nix Flake does not include
        # generated / ignored files in its build context.
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

      homeConfigurations."erwin" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./nix/home-manager/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit nixgl;
          theme = builtins.fromJSON (builtins.readFile "${self.packages.erwin-theme}/theme.json");
        };
      };
    };
}
