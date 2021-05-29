{
	description = "A very basic flake";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixos-hardaware.url = "github:NixOs/nixos-hardware/master";
		home-manager.url = "github:nix-community/home-manager";
		emacs-overlay.url = "github:nix-community/emacs-overlay"; 
	};


	outputs = inputs@{ self, home-manager, nixpkgs, ...}:
		let	
			system = "x86_64-linux";
			mkBaseSystem = nixConfig: extraModules: nixpkgs.lib.nixosSystem
			{
				inherit system;
				specialArgs = { inherit system inputs; };
				modules = ([
					#System configuration
					nixConfig

					#General modules
					# ./modules/general1.nix		
					# ./modules/general2.nix		
					
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.ba1ash = import ./home.nix {
							inherit inputs system;
							pkgs = import nixpkgs { inherit system; };	
						};
					}
					
					
				] ++ extraModules);
			};
		in
		{
			nixosConfigurations.x1c4 = mkBaseSystem
				./hosts/x1c4.nix
				[
					# ./modules/general1.nix			
					# ./modules/general2.nix			
				];
#			nixosConfigurations.homeborn = mkBaseSystem
#				.hosts/homeborn.nix
#				[
#					
#				];
		};
}
