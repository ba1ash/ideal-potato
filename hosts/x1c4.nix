# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [
		./x1c4_hw.nix
		./common.nix
	];

	networking.hostName = "x1c4";
	networking.wireless.enable = true;
	networking.wireless.networks = {
		"HUAWEI-TKua" = {
			pskRaw = "57f19f1f2e3d239651980af6009340d07e8387e31505147f022b6d8ffbbcb0ab";	
		};
	};

	networking.useDHCP = false;
	networking.interfaces.enp0s31f6.useDHCP = true;
	networking.interfaces.wlp4s0.useDHCP = true;
	networking.interfaces.wwp0s20f0u2i12.useDHCP = true;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "20.09"; # Did you read the comment?
}
