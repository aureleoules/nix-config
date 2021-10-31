{ pkgs, ... }:

{
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

    package = pkgs.picom.overrideAttrs (o: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "ibhagwan";
        rev = "60eb00ce1b52aee46d343481d0530d5013ab850b";
        sha256 = "1m17znhl42sa6ry31yiy05j5ql6razajzd6s3k2wz4c63rc2fd1w";
      };
    });
  };
}
