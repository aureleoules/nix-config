{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      tmp = "cd \$(mktemp -d)";
      icat = "kitty +kitten icat";
    };

    initExtra = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      export ZSH_THEME="robbyrussell"
      plugins=(git)
      source $ZSH/oh-my-zsh.sh
      eval $(keychain --eval id_ed25519 -q)
    '';
  };
}
