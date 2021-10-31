{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "aureleoules";
  home.homeDirectory = "/home/aureleoules";

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;
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
    pkgs.font-awesome
    pkgs.feh
    pkgs.scrot
    pkgs.criterion
    pkgs.wpa_supplicant

    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Mononoki" ]; })
  ];


  programs.git = {
    enable = true;
    userName = "Aurèle Oulès";
    userEmail = "aurele@oules.com";
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      # mpdSupport = true; mpd_clientlib = pkgs.mpd_clientlib;
      i3Support = true; i3 = pkgs.i3; jsoncpp = pkgs.jsoncpp;
    };
    script = ''~/.config/polybar/custom/launch.sh'';
  };

  services.picom = {
    enable = true;

    shadow = true;
    activeOpacity = "1.0";
    inactiveOpacity = "0.95";
    backend = "glx";

    extraOptions = ''
      corner-radius = 8;
      detect-rounded-corners = true;
      rounded-corners-exclude = [
        "window_type = 'dock'",
        "window_type = 'desktop'"
      ];
    '';

    package = pkgs.picom.overrideAttrs(o: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "ibhagwan";
        rev = "60eb00ce1b52aee46d343481d0530d5013ab850b";
        sha256 = "1m17znhl42sa6ry31yiy05j5ql6razajzd6s3k2wz4c63rc2fd1w";
      };
    });
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      tmp = "cd \$(mktemp -d)";
      icat="kitty +kitten icat";
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

  programs.kitty = {
    enable = true;
    font = {
      name = "mononoki Bold Nerd Font Complete Mono";
      size = 10;
    };
    settings = {
      enabled_layouts = "grid";
      font_size = 10;
      window_padding_width = 4;
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+l" = "previous_window";
      "ctrl+shift+m" = "next_window";
    };
  };

  programs.vscode = {
    enable = true;
    userSettings = {
      "editor.fontFamily" = "mononoki Nerd Font";
      "editor.fontWeight" = "bold";
      "workbench.colorTheme" =  "Black";
    };
    extensions = (with pkgs.vscode-extensions; [
      ms-vscode.cpptools
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Black";
        publisher = "Jaakko";
        version = "0.12.0";
        sha256 = "0d75w81p1jiq8zpky0p1jdvxyc2pnpmnp05ga2hsbq88w2chqh3c";
      }
      {
        name = "copilot";
        publisher = "Github";
        version = "1.6.3571";
        sha256 = "00sw75my466mzsrqjafzxbzv397vmlfafllbljvql6crxpl45v57";
      }
      {
        name = "vim";
        publisher = "vscodevim";
        version = "1.21.10";
        sha256 = "0c9m7mc2kmfzj3hkwq3d4hj43qha8a75q5r1rdf1xfx8wi5hhb1n";
      }
    ];
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
