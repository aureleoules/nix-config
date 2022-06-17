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
    unstable.discord
    deluge
    vscode
    tdesktop
    insomnia
    rustup
    nodejs
    yarn
    font-awesome
    feh
    scrot
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
    tor-browser-bundle-bin
    vlc

    # programming
    python3
    gcc11
    unstable.criterion.dev
    # binutils
    gnumake
    clang-tools
    man-pages
    man-pages-posix
    killall
    libsecret
    unstable.bitcoin
    autoconf
    automake
    libtool
    autoconf
    m4
    unstable.ledger-live-desktop
    ledger-udev-rules
    shellcheck
    # unstable.google-chrome
    unstable.electrum
    unzip
    reaper
    ardour
    sox
    meson
    ninja
    cmake
    pkg-config
    pre-commit
    slack
    # obinskit
    dash
    unstable.minecraft
    cppcheck
    openhmd
    wineWowPackages.stable
    #(wine.override { wineBuild = "wine64"; })
    unstable.go_1_18
    openjdk
    imwheel
    zoom-us
    polymc
    gh
    texlive.combined.scheme-full
    ccache
    jetbrains.clion

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
