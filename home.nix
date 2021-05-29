{ pkgs, ... }:
{
	home.packages = [
		pkgs.htop
		pkgs.fortune
	];
	programs.home-manager.enable = true;
	programs = {
		git = {
			enable = true;
			userName = "Pavel Balashov";
			userEmail = "ba1ashpash@gmail.com";
		};
	};
	home.username = "ba1ash";
	home.homeDirectory = "/home/ba1ash";
	home.stateVersion = "21.05";
}
