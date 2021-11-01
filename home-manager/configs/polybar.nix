{ pkgs, ... }:

let
  bg = "#151515";
  bg-alt = "#232323";
  bg-darker = "#151515";
  fg = "#ffffff";
  fg-alt = "#474747";
  
  blue = "#2979ff";
  cyan = "#00e5ff";
  green = "#00e676";
  orange = "#ff9100";
  pink = "#f50057";
  purple = "#d500f9";
  red = "#ff1744";
  yellow = "#ffea00";
  
  black = "#000";
  white = "#FFF";
  
  trans = "#00000000";
  semi-trans-black = "#aa000000";
in 
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      # mpdSupport = true; mpd_clientlib = pkgs.mpd_clientlib;
      i3GapsSupport = true;
      pulseSupport = true;
      jsoncpp = pkgs.jsoncpp;
    };
    config = {
      "bar/main" = {
        monitor = "\${env:MONITOR}";
        width = "100%";
        height = 30;
        offset-y = 0;
        bottom = true;
        fixed-center = true;

        wm-restack = "i3";

        override-redirect = false;

        scroll-up = "next";
        scroll-down = "prev";

        enable-ipc = true;

        background = bg;
        foreground = fg;

        font-0 = "Iosevka Nerd Font Mono:style=Medium:size=10;3";
        font-1 = "Iosevka Nerd Font Mono:style=Bold Oblique:size=10;3";
        font-2 = "Iosevka Nerd Font:size=12;3";
        font-3 = "coins:style=Regular:9;2";
        font-4 = "Material Icons Outlined:9;4";
        modules-left = "i3 bitcoin bitcoin-height";
        modules-center = "date";
        # modules-center = "mpd";
        modules-right = "wired wlan cpu memory temperature xbacklight pulseaudio battery";

        tray-background = bg;
        tray-position = "right";
        tray-maxsize = 16;

        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
      }; 

      "module/bitcoin" = {
        type = "custom/script";
        interval = 60;
        format-prefix = " ";
        format-padding = 1;
        format-prefix-foreground = yellow;
        format-suffix = " €";

        exec = ''
          printf "%'d" $(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur" | jq -r '.bitcoin.eur')
        '';
      };

      "module/bitcoin-height" = {
        type = "custom/script";
        interval = 10;
        format-suffix = " blocks";
        format-padding = 1;
        format-prefix-foreground = yellow;

        exec = ''
          printf "%'d" $(curl -s "https://blockstream.info/api/blocks/tip/height")
        '';
      };

      "module/wired" = {
        type = "internal/network";
        interface = "enp8s0";
        interval = "1.0";

        format-connected = "<label-connected>";
        format-connected-padding = 1;
        format-connected-prefix = "%{T2}ETH %{T-}";
        format-connected-prefix-foreground = fg-alt;
        label-connected = "%{T1}%downspeed%%{T-}";
        label-connected-foreground = fg;

        format-disconnected = "<label-disconnected>";
        format-disconnected-padding = 1;
        label-disconnected = "%{T2}ETH%{T-}";
        label-disconnected-foreground = red;
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "wlp7s0";
        interval = "1.0";

        format-connected = "<label-connected>";
        format-connected-padding = 1;
        format-connected-prefix = "%{T2}WLAN %{T-}";
        format-connected-prefix-foreground = fg-alt;
        label-connected = "%{T1}%downspeed%%{T-}";
        label-connected-foreground = fg;

        format-disconnected = "<label-disconnected>";
        format-disconnected-padding = 1;
        label-disconnected = "%{T2}WLAN%{T-}";
        label-disconnected-foreground = red;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        use-ui-max = false;

        format-volume = "<label-volume>";
        format-volume-padding = 1;
        format-volume-prefix = "%{T2}VOL%{T-}";
        format-volume-prefix-foreground = fg-alt;
        label-volume = "%{T1}%percentage%%%{T-}";
        label-volume-padding = 1;

        format-muted = "<label-muted>";
        format-muted-foreground = red;
        format-muted-padding = 1;
        format-muted-prefix = "%{T2}VOL%{T-}";
        format-muted-prefix-foreground = red;
        label-muted = "%{T1}%percentage%%%{T-}";
        label-muted-padding = 1;

        click-right = "pavucontrol&";
      };

      "module/i3" = {
        type = "internal/i3";
        index-sort = true;

        format = "<label-state> <label-mode>";
        wrapping-scroll = false;
        enable-scroll = true;
        pin-workspaces = true;

        label-mode = "%mode%";
        label-mode-padding = 1;
        label-mode-foreground = fg;

        label-focused = "%{T2}%index%%{T-}";
        label-focused-foreground = fg;
        label-focused-padding = 1;

        label-unfocused = "%{T2}%index%%{T-}";
        label-unfocused-foreground = fg-alt;
        label-unfocused-padding = 1;

        label-visible = "%{T2}%index%%{T-}";
        label-visible-foreground = fg-alt;
        label-visible-padding = 1;

        label-urgent = "%{T2}%index%%{T-}";
        label-urgent-foreground = red;
        label-urgent-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;

        time = "%H:%M";
        time-alt = "%a, %b %d %H:%M:%S";

        format = "<label>";
        format-padding = 1;
        label = "%{T1}%time%%{T-}";
        label-padding = 1;
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "ACAD";
        full-at = 98;

        format-charging = "<label-charging>";
        format-charging-padding = 1;
        format-charging-prefix = "%{T2}BAT%{T-}";
        format-charging-prefix-foreground = fg-alt;
        label-charging = "%{T1}%percentage%%%{T-}";
        label-charging-padding = 1;

        format-discharging = "<label-discharging>";
        format-discharging-padding = 1;
        format-discharging-prefix = "%{T2}BAT%{T-}";
        format-discharging-prefix-foreground = fg-alt;
        label-discharging = "%{T1}%percentage%%%{T-}";
        label-discharging-padding = 1;

        format-full = "<label-full>";
        format-full-padding = 1;
        format-full-prefix = "%{T2}BAT%{T-}";
        format-full-prefix-foreground = fg-alt;
        label-full = "%{T1}%percentage%%%{T-}";
        label-full-padding = 1;
      };

      "module/cpu" = {
          type = "internal/cpu";
          interval = 1;

          format = "<label>";
          format-padding = 1;
          format-prefix = "%{T2}CPU%{T-}";
          format-prefix-foreground = fg-alt;
          label = "%{T1}%percentage:2%%%{T-}";
          label-padding = 1;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 1;

        format = "<label>";
        format-padding = 1;
        format-prefix = "%{T2}MEM%{T-}";
        format-prefix-foreground = fg-alt;
        label = "%{T1}%percentage_used%%%{T-}";
        label-foreground = fg;
        label-padding = 1;
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
        warn-temperature = 60;

        format = "<label>";
        format-padding = 1;
        format-prefix = "%{T2}TEMP%{T-}";
        format-prefix-foreground = fg-alt;
        format-warn = "<label-warn>";
        format-warn-padding = 1;
        format-warn-prefix = "%{T2}TEMP%{T-}";
        format-warn-prefix-foreground = fg-alt;
        label = "%{T1}%temperature-c%%{T-}";
        label-padding = 1;
        label-warn = "%{T1}%temperature-c%%{T-}";
        label-warn-padding = 1;
      };
    };
    script = "";
  };
}

