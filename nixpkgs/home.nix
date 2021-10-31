{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "aureleoules";
  home.homeDirectory = "/home/aureleoules";

  programs.git = {
    enable = true;
    userName = "Aurèle Oulès";
    userEmail = "aurele@oules.com";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
	tmp = "cd \$(mktemp -d)";
    };

    initExtra = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      export ZSH_THEME="robbyrussell"
      plugins=(git)
      source $ZSH/oh-my-zsh.sh
    '';
  };

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
