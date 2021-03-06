{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };


  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      mkBaseSystem = host: extraModules: nixpkgs.lib.nixosSystem
        {
          inherit system;
          specialArgs = { inherit system inputs; };
          modules = ([
            #System configuration
            (./. + (builtins.toPath "/hosts/${host}.nix"))

            #General modules
            # ./modules/general1.nix
            # ./modules/general2.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ba1ash = import ./home.nix {
                inherit inputs system host;
                pkgs = import nixpkgs {
                  inherit system;
                  config.allowUnfree = true;
                };
              };
            }


          ] ++ extraModules);
        };
    in
    {
      nixosConfigurations.x1c4 = mkBaseSystem
        "x1c4"
        [
          # ./modules/general1.nix
          # ./modules/general2.nix
        ];
      nixosConfigurations.p14 = mkBaseSystem
        "p14"
        [
        ];
      nixosConfigurations.homews = mkBaseSystem
        "homews"
        [
        ];
      devShell.x86_64-linux =
        with nixpkgs.legacyPackages.x86_64-linux;
        mkShell {
          buildInputs = [
            nixpkgs-fmt
          ];

          shellHook = ''
            # add extension
          '';
        };
    };
}
