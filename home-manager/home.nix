{ config, pkgs, ... }:

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
    font-awesome
    feh
    scrot
    criterion
    wpa_supplicant
    libsecret
    jq

    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Mononoki" "Iosevka"  ]; })
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
