{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Aurèle Oulès";
    userEmail = "aurele@oules.com";
  };
}
