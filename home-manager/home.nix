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
    mariadb.client
    flameshot
    spotify
    unstable.discord
    deluge
    vscode
    tdesktop
    insomnia
    rustup
    # cargo
    # rustc
    nodejs
    yarn
    font-awesome
    feh
    scrot
    # wpa_supplicant
    libsecret
    jq
    thunderbird
    libreoffice
    teams
    gdb
    valgrind
    gtop
    bat
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
    # gcc11
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
    # unstable.electrum
    unzip
    meson
    ninja
    cmake
    pkg-config
    pre-commit
    slack
    # obinskit
    dash
    unstable.minecraft
    # cppcheck
    # wineWowPackages.stable
    #(wine.override { wineBuild = "wine64"; })
    unstable.go_1_18
    openjdk
    imwheel
    prismlauncher
    gh
    ccache
    # jetbrains.clion
    clang_14
    jetbrains.clion


    # bitcoin
      autoconf
      automake
      libtool
      pkg-config
      boost177
      libevent
      zeromq
      sqlite
      db48
      virtualenv

      qt5Full
      qt5.qttools
      # functional tests
      python3Packages.setuptools
      python3Packages.vulture

      # debugging
      gdb

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
