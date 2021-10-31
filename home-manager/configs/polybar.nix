{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      # mpdSupport = true; mpd_clientlib = pkgs.mpd_clientlib;
      i3Support = true;
      i3 = pkgs.i3;
      jsoncpp = pkgs.jsoncpp;
    };
    script = ''~/.config/polybar/custom/launch.sh'';
  };
}
