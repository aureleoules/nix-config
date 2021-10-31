{ pkgs, ... }:

{
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
}
