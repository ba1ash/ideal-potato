# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./p14_hw.nix
    ./common.nix
  ];

  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/bb3932cb-9dac-46c8-ae41-e8cdfec4ced1";
      preLVM = true;
    };
  };

  networking.hostName = "p14";
  networking.extraHosts =
    ''
     127.0.0.1 crowdcigar.com
   '';

  networking.useDHCP = false;
  networking.interfaces.enp0s13f0u2u1.useDHCP = true;
  services.xserver.videoDrivers = [ "intel" ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_12;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE ba1ash WITH LOGIN PASSWORD SUPERUSER 'ba1ash' CREATEDB;
    '';
  };

  environment.systemPackages = with pkgs; [
    awscli
    ssm-session-manager-plugin
    putty
    virt-manager
    slack
    postman
  ];
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  users.users.ba1ash.extraGroups = [ "libvirtd" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
