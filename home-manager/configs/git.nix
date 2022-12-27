{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Aurèle Oulès";
    userEmail = "aurele@oules.com";

    extraConfig = {
      core.editor = "vim";
      user.signingKey = "55F3976F7001D998";
      commit.pgpsign = true;
    };
  };
}
