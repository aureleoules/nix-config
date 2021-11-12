{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
    ./configs/git.nix
    ./configs/polybar.nix
    ./configs/picom.nix
    ./configs/vim.nix
    ./configs/zsh.nix
    ./configs/kitty.nix
    ./configs/vscode.nix
    ./configs/i3.nix
    ./configs/rofi.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "aureleoules";
  home.homeDirectory = "/home/aureleoules";

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    git
    wget
    docker
    docker-compose
    htop
    kitty
    file
    curl
    neofetch
    nixpkgs-fmt
    zsh
    keychain
    oh-my-zsh
    mysql-client
    flameshot
    spotify
    discord
    deluge
    vscode
    tdesktop
    insomnia
    go
    rustup
    nodejs
    yarn
    font-awesome
    feh
    scrot
    criterion
    wpa_supplicant
    libsecret
    jq
    thunderbird
    libreoffice
    teams
    gdb
    valgrind
    gtop
    bat
    openvpn
    rofi
    i3-gaps
    ranger
    mpd
    pywal
    calc
    networkmanager_dmenu

    # applications
    firefox
    unstable.tor-browser-bundle-bin
    vlc

    # programming
    python3
    gcc
    criterion
    binutils
    gnumake
    clang-tools
    man-pages
    man-pages-posix
    killall
    virtualbox
    libsecret
    unstable.bitcoin
    autoconf
    automake
    libtool
    autoconf
    m4
    ledger-live-desktop
    ledger-udev-rules
    shellcheck
    google-chrome

    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Mononoki" "Iosevka" ]; })
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
