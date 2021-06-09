# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [ ./x1c4_hw.nix ];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "x1c4";
	networking.wireless.enable = true;
	networking.wireless.networks = {
		"HUAWEI-TKua" = {
			pskRaw = "57f19f1f2e3d239651980af6009340d07e8387e31505147f022b6d8ffbbcb0ab";	
		};
	};

	time.timeZone = "Europe/Minsk";

	networking.useDHCP = false;
	networking.interfaces.enp0s31f6.useDHCP = true;
	networking.interfaces.wlp4s0.useDHCP = true;
	networking.interfaces.wwp0s20f0u2i12.useDHCP = true;

	services.xserver = {
		enable = true;
		autorun = true;
		layout = "us,ru";
		xkbOptions = "caps:escape,ctrl:swap_lalt_lctl,altwin:swap_lalt_lwin,grp:rctrl_toggle";
		desktopManager = {
			xterm.enable = false;
			xfce = {
				enable = true;
				noDesktop = true;
				enableXfwm = false;
			};
		};
		displayManager = {
			defaultSession = "xfce+i3";
			lightdm.greeters.mini ={
				enable = true;
				user = "ba1ash";
				extraConfig = ''
					[greeter]
					show-password-label = false
						[greeter-theme]
						background-image = ""
							'';
			};
		};
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu
				i3status
				i3lock
				i3blocks
			];
		};
	};

	console.useXkbConfig = true;

	sound.enable = true;
	hardware.pulseaudio.enable = true;

	users.users.ba1ash = {
		isNormalUser = true;
		home = "/home/ba1ash";
		extraGroups = [ "wheel" ];
	};

	environment.systemPackages = with pkgs; [
		vim
		alacritty
		firefox
		qutebrowser
		zeal
	];
	environment.variables.EDITOR = "vim";
	fonts.fonts = with pkgs; [
		dejavu_fonts
		font-awesome_5
		powerline-fonts
	];

	nix = {
		package = pkgs.nixUnstable;
		extraOptions = ''
			experimental-features = nix-command flakes
			'';
	};

	services.openssh.enable = true;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "20.09"; # Did you read the comment?
}
