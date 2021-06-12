{  pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    htop
    fortune
    jmtpfs
    youtube-dl
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
    dropbox
    unzip
    mitscheme
    pandoc
    zeal
    firefox
    chromium
    qutebrowser
  ];

  environment.interactiveShellInit = "
    set -o vi
  ";
}
