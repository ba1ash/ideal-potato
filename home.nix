{ pkgs, ... }:
{
	xsession.windowManager.i3 = {
		enable = true;
		config = rec {
			modifier = "Mod1";
			terminal = "alacritty";
			fonts = { 
				names = ["DejaVu Sans Mono, FontAwesomeSFree"];
				style = "Bold Semi-Condensed";
				size = 15.0;
			};
			keybindings = pkgs.lib.mkOptionDefault {
				"${modifier}+h" = "focus left";
				"${modifier}+j" = "focus down";
				"${modifier}+k" = "focus up";
				"${modifier}+l" = "focus left";

				"${modifier}+Shift+h" = "move left";
				"${modifier}+Shift+j" = "move down";
				"${modifier}+Shift+k" = "move up";
				"${modifier}+Shift+l" = "move left";
			};
			bars = [
				{
					fonts = {
						 names = ["DejaVu Sans Mono, FontAwesomeSFree"];
						 style = "Bold Semi-Condensed";
						 size = 15.0;
					};
				}
			];

		};
	};
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
		bash = {
			enable = true;
		};
#		i3status-rust = {
#			enable = true;
#		};
	};
	home.username = "ba1ash";
	home.homeDirectory = "/home/ba1ash";
	home.stateVersion = "21.05";
}
