{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "aureleoules";
  home.homeDirectory = "/home/aureleoules";

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.zsh
    pkgs.keychain
    pkgs.oh-my-zsh
    pkgs.mysql-client
    pkgs.flameshot
    pkgs.spotify
    pkgs.discord
    pkgs.deluge
    pkgs.vscode
    pkgs.tdesktop
    pkgs.insomnia
    pkgs.go
    pkgs.rustup
    pkgs.nodejs
  ];

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
      eval $(keychain --eval id_ed25519 -q)
    '';
  };
  
  programs.vim = {
    enable = true;
    settings = {
      number = true;
    };
    extraConfig = ''
      set number
      set runtimepath+=/home/aureleoules/config/home-manager/configs/vim
      source /home/aureleoules/config/home-manager/configs/vim/vimrcs/basic.vim
      source /home/aureleoules/config/home-manager/configs/vim/vimrcs/filetypes.vim
      source /home/aureleoules/config/home-manager/configs/vim/vimrcs/plugins_config.vim
      source /home/aureleoules/config/home-manager/configs/vim/vimrcs/extended.vim
      try
        source /home/aureleoules/config/home-manager/configs/vim/vimrcs/my_configs.vim
      catch
      endtry
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
