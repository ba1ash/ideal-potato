{ pkgs, inputs, host, ... }:
{
	imports = [ inputs.nix-doom-emacs.hmModule ];
	xsession.windowManager.i3 = {
		enable = true;
		config = rec {
			modifier = "Mod1";
			terminal = "alacritty";
			fonts = { 
				names = ["FontAwesomeSFree"];
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
						names = ["FontAwesomeSFree"];
						style = "Bold Semi-Condensed";
						size = 15.0;
					};
					statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
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
		alacritty = {
			enable = true;
			# https://github.com/alacritty/alacritty/blob/master/alacritty.yml
			settings = {
				key_bindings = [
					{
						key =  "Return";
						mods = "Control|Shift";
						action = "SpawnNewInstance";
					}
				];
			};
		};
		fzf.enable = true;
		qutebrowser = {
			enable = true;
			settings = {
				fonts.default_size = "20pt";
				qt.highdpi = true;
			};
			keyBindings = {
				command = {
					"<Ctrl-j>" = "completion-item-focus next";
					"<Ctrl-k>" = "completion-item-focus --history prev";
				};
			};
		};
		doom-emacs = {
			enable = true;
			doomPrivateDir = ./doom.d;
		};
		git = {
			enable = true;
			userName = "Pavel Balashov";
			userEmail = "ba1ashpash@gmail.com";
		};
		bash = {
			enable = true;
		};
		i3status-rust = {
			enable = true;
			bars = {
				bottom = {
					blocks = import (./. + (builtins.toPath "/blocks_${host}.nix"));
					settings = {
						theme =  {
							name = "solarized-dark";
							overrides = {
								idle_bg = "#123456";
								idle_fg = "#abcdef";
							};
						};
					};
					icons = "awesome5";
					theme = "gruvbox-dark";
				};
			};
		};
	};
	home.username = "ba1ash";
	home.homeDirectory = "/home/ba1ash";
	home.stateVersion = "21.05";
}
