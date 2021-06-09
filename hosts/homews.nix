# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./homews_hw.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.bluetooth.enable = true;


  fonts.fonts = with pkgs; [
    dejavu_fonts
    font-awesome_5
    powerline-fonts
  ];
  networking.hostName = "homews";
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;
  networking.iproute2.enable = true;
  #  networking.extraHosts =
  #  ''
  #    127.0.0.1 youtube.com
  #    127.0.0.1 www.youtube.com
  #  '';

  time.timeZone = "Europe/Minsk";

  environment.systemPackages = with pkgs; [
    niv
    jmtpfs
    youtube-dl
    fzf
    neovim
    alacritty
    pciutils
    glxinfo
    chromium
    qutebrowser
    tdesktop
    git
    tmux
    spotify
    spotify-tui
    spotifyd
    wine
    bash
    ripgrep
    fd
    emacs
    coreutils
    clang
    iproute
    vlc
    direnv
    libreoffice
    steam
    anki
    dropbox
    pandoc
    unzip
    mitscheme
    gnuplot
    discord
    docker-compose
    element-desktop
    zeal
    firefox
  ];
  environment.interactiveShellInit = "
    set -o vi
  ";

  programs.ssh.startAgent = true;
  programs.adb.enable = true;

  services.openssh.enable = true;
  services.lorri.enable = true;	
  services.flatpak.enable = true;
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_12;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE ba1ash WITH LOGIN PASSWORD 'ba1ash' CREATEDB;
    '';
  };
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us,ru";
    xkbOptions = "caps:escape,ctrl:swap_lalt_lctl,altwin:swap_lalt_lwin,grp:rctrl_toggle";
    videoDrivers = ["nvidia"];
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    displayManager.defaultSession = "xfce+i3";
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "ba1ash";
      extraConfig = ''
        [greeter]
        show-password-label = false
        [greeter-theme]
        background-image = ""
      '';
      
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

  users.users.ba1ash = {
    isNormalUser = true;
    home = "/home/ba1ash";
    extraGroups = [ "wheel" "adbusers" "docker" ];
  };


  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: super : {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      }; 
    })
  ];
  console.useXkbConfig = true;
  nix = {
    allowedUsers = ["ba1ash"];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      '';
  };
  virtualisation.docker.enable = true;
  xdg.portal.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
