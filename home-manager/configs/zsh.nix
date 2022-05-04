{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      tmp = "cd \$(mktemp -d)";
      icat = "kitty +kitten icat";
      gitc = "git shortlog -s -n --all --no-merges";
      sus = "systemctl suspend";
      dus = "du -hs * | sort -h";
      h = "ssh home.aureleoules.com";
      gplusinternet = "nmtui";
    };

    initExtra = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      export ZSH_THEME="robbyrussell"
      export PATH=/home/aureleoules/.nix-profile/lib/openjdk:$PATH
      export JDK_HOME=/home/aureleoules/.nix-profile/lib/openjdk
      plugins=(git)
      source $ZSH/oh-my-zsh.sh
      eval $(keychain --eval id_ed25519 -q)
      export PATH=~/go/bin:$PATH
      xset r rate 180 25
    '';
  };
}
