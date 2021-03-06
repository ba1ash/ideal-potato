{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    hwinfo
    lshw
    htop
    fortune
    jmtpfs
    yt-dlp
    neovim
    fzf
    alacritty
    tdesktop
    git
    spotify
    bash
    ripgrep
    fd
    coreutils
    clang
    vlc
    direnv
    libreoffice
    anki
    unzip
    pandoc
    zeal
    firefox
    chromium
    qutebrowser
    flameshot
    feh
    _1password
    jq
    usbutils
    nodejs
    nodePackages.typescript-language-server
    zoom-us
    wine
    zip
    _1password-gui
    gsettings-desktop-schemas
    thunderbird
    wget
  ];
  environment = {
    interactiveShellInit = "
      set -o vi
    ";
  };
  nixpkgs.config.allowUnfree = true;
  fonts.fonts = with pkgs; [
    dejavu_fonts
    font-awesome_5
    powerline-fonts
  ];
  time.timeZone = "Europe/Amsterdam";

  programs.ssh.startAgent = true;
  services.openssh.enable = true;

  programs.adb.enable = true;

  services.xserver = {
    enable = true;
    autorun = false;
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
        i3lock
        i3blocks
      ];
    };
  };
  console.useXkbConfig = true;
  users.users.ba1ash = {
    isNormalUser = true;
    home = "/home/ba1ash";
    extraGroups = [ "wheel" "adbusers" "docker" "networkmanager" ];
  };
  nix = {
    settings = {
      allowed-users = [ "ba1ash" ];
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  networking.networkmanager.enable = true; 
  programs.nm-applet.enable = true;
  virtualisation.docker.enable = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
    })
  ];
}
