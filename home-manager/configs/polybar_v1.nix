{ pkgs, ... }:

let
  bg = "#111";
  bgalt = "#444";
  fg = "#ddd";
  fgalt = "#555";
  primary = "#ffb52a";
  secondary = "#e60053";
  alert = "#bd2c40";
  accent = "#4bc98a";
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      # mpdSupport = true; mpd_clientlib = pkgs.mpd_clientlib;
      i3GapsSupport = true;
      jsoncpp = pkgs.jsoncpp;
    };
    config = {
      "bar/main" = {
        # monitor = "\${env:MONITOR}";
        width = "100%";
        height = "20px";
        offset-x = "0%";
        offset-y = "0%";
        radius = 0;
        fixed-center = false;
        bottom = true;
        underline-size = 0;
        background = bg;
        foreground = fg;

        line-size = 0;
        line-color = "#f00";

        border-size = 0;
        border-color = "#00000000";

        padding-left = 0;
        padding-right = 2;

        module-margin-left = 1;
        module-margin-right = 2;

        font-0 = "ShureTechMono Nerd Font:pixelsize=10;4";
        font-1 = "ShureTechMono Nerd Font:fontformat=truetype:size=12;3";
        font-2 = "ShureTechMono Nerd Font:pixelsize=12;1";
        font-3 = "ShureTechMono Nerd Font:fontformat=truetype:size=17;3";
        font-4 = "ShureTechMono Nerd Font:fontformat=truetype:size=14;3";

        modules-left = "i3";
        modules-right = "cpu memory xbacklight pulseaudio wlan battery temperature date powermenu";
        tray-position = "right";
        wm-restack = "i3";

        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";

        cursor-click = "pointer";
        cursor-scroll = "pointer";
      };

      # [module/xwindow]
      # type = internal/xwindow;
      # label = %title:0:30:...%;

      # [module/xkeyboard]
      # type = internal/xkeyboard;
      # blacklist-0 = num lock;

      # format-prefix = " "
      # format-prefix-foreground = ${colors.foreground-alt}
      # format-prefix-underline = ${colors.secondary}

      # label-layout = %layout%
      # label-layout-underline = ${colors.secondary}

      # label-indicator-padding = 2
      # label-indicator-margin = 1
      # label-indicator-background = ${colors.secondary}
      # label-indicator-underline = ${colors.secondary}

      # [module/filesystem]
      # type = internal/fs
      # interval = 25

      # mount-0 = /

      # label-mounted = %{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%
      # label-unmounted = %mountpoint% not mounted
      # label-unmounted-foreground = ${colors.foreground-alt}

      # [module/bspwm]
      # type = internal/bspwm

      # label-focused = %index%
      # label-focused-background = ${colors.accent}
      # label-focused-underline= ${colors.background}
      # label-focused-padding = 2

      # label-occupied = %index%
      # label-occupied-padding = 2

      # label-urgent = %index%!
      # label-urgent-background = ${colors.alert}
      # label-urgent-padding = 2

      # label-empty = %index%
      # label-empty-foreground = ${colors.foreground-alt}
      # label-empty-padding = 2

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;
        enable-scroll = true;

        pin-workspaces = true;

        label-mode-padding = 2;
        label-mode-foreground = "#000";
        label-mode-background = primary;

        label-focused = "%name%";
        label-focused-background = accent;
        label-focused-underline = bg;
        label-focused-foreground = bg;
        label-focused-padding = 2;

        label-unfocused = "%name%";
        label-unfocused-padding = 2;

        label-visible = "%name%";
        label-visible-background = "\${self.label-focused-background}";
        label-visible-underline = "\${self.label-focused-underline}";
        label-visible-padding = "\${self.label-focused-padding}";
        label-urgent = "%name%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-underline = "\${self.label-focused-underline}";
        label-urgent-padding = 2;
      };

      # [module/mpd]
      # type = internal/mpd
      # format-online = <label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>

      # icon-prev = 
      # icon-stop = 
      # icon-play = 
      # icon-pause = 
      # icon-next = 

      # label-song-maxlen = 25
      # label-song-ellipsis = true

      # [module/xbacklight]
      # type = internal/xbacklight

      # format = <label> <bar>
      # label = 

      # bar-width = 10
      # bar-foreground = ${colors.accent}
      # bar-gradient = false
      # bar-indicator = ⏽
      # bar-indicator-font = 2
      # bar-fill = ⏽
      # bar-fill-font = 2
      # bar-fill-foreground = ${colors.accent}
      # bar-empty = ⏽
      # bar-empty-font = 2
      # bar-empty-foreground = ${colors.foreground-alt}

      # [module/backlight-acpi]
      # inherit = module/xbacklight
      # type = internal/backlight
      # card = intel_backlight

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "﬙ ";
        format-prefix-font = 4;
        format-prefix-foreground = accent;
        format-underline = "#f90000";
        label = "%percentage:2%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix-font = 4;
        # format-prefix = "﬙ ";
        format-prefix = "";
        format-prefix-foreground = accent;
        format-underline = "#4bffdc";
        label = "%percentage_used%%";
      };
      # [module/memory]

      # [module/wlan]
      # type = internal/network
      # interface = wlp2s0
      # interval = 3.0

      # format-connected = <ramp-signal> <label-connected>
      # format-connected-underline = #9f78e1
      # label-connected = %essid%

      # format-disconnected = 睊

      # ramp-signal-0 = 直
      # ramp-signal-foreground = ${colors.accent}

      # [module/eth]
      # type = internal/network
      # interface = enp0s31f6
      # interval = 3.0

      # format-connected-underline = #55aa55
      # format-connected-prefix = " "
      # format-connected-prefix-foreground = ${colors.foreground-alt}
      # label-connected = %local_ip%

      # format-disconnected =

      # [module/date]
      # type = internal/date
      # interval = 5

      # date =
      # date-alt = " %Y-%m-%d"

      # time = %H:%M
      # time-alt = %H:%M:%S

      # format-prefix = 
      # format-prefix-foreground = ${colors.accent}
      # format-prefix-font = 5
      # format-underline = #0a6cf5

      # label = %date% %time%

      # [module/pulseaudio]
      # type = internal/pulseaudio

      # format-volume = <label-volume> <bar-volume>
      # label-volume = VOL %percentage%%
      # label-volume-foreground = ${root.foreground}

      # label-muted = muted
      # label-muted-foreground = #666

      # bar-volume-width = 10
      # bar-volume-foreground = ${colors.accent}

      # bar-volume-gradient = false
      # bar-volume-indicator = ⏽
      # bar-volume-indicator-font = 2
      # bar-volume-fill = ⏽
      # bar-volume-fill-font = 2
      # bar-volume-fill-foreground = ${colors.accent}
      # bar-volume-empty = ⏽
      # bar-volume-empty-font = 2
      # bar-volume-empty-foreground = ${colors.foreground-alt}

      # [module/alsa]
      # type = internal/alsa

      # format-volume = <label-volume> <bar-volume>
      # label-volume = VOL
      # label-volume-foreground = ${root.foreground}

      # format-muted-prefix = " "
      # format-muted-foreground = ${colors.foreground-alt}
      # label-muted = sound muted

      # bar-volume-width = 10
      # bar-volume-foreground-0 = #55aa55
      # bar-volume-foreground-1 = #55aa55
      # bar-volume-foreground-2 = #55aa55
      # bar-volume-foreground-3 = #55aa55
      # bar-volume-foreground-4 = #55aa55
      # bar-volume-foreground-5 = #f5a70a
      # bar-volume-foreground-6 = #ff5555
      # bar-volume-gradient = false
      # bar-volume-indicator = |
      # bar-volume-indicator-font = 2
      # bar-volume-fill = ─
      # bar-volume-fill-font = 2
      # bar-volume-empty = ─
      # bar-volume-empty-font = 2
      # bar-volume-empty-foreground = ${colors.foreground-alt}

      # [module/battery]
      # type = internal/battery
      # battery = BAT0
      # adapter = AC
      # full-at = 98
      # label-discharging-margin-left = 0
      # label-charging-margin-left = 1

      # format-charging = <animation-charging><label-charging>
      # format-charging-underline = #ffb52a

      # format-discharging = <ramp-capacity><label-discharging>
      # format-discharging-underline = ${self.format-charging-underline}

      # format-full-prefix = ""
      # format-full-prefix-foreground = ${colors.foreground-alt}
      # format-full-underline = ${self.format-charging-underline}

      # ramp-capacity-0 = 
      # ramp-capacity-1 = 
      # ramp-capacity-2 = 
      # ramp-capacity-3 = 
      # ramp-capacity-4 = 
      # ramp-capacity-5 = 
      # ramp-capacity-6 = 
      # ramp-capacity-7 = 
      # ramp-capacity-8 = 
      # ramp-capacity-9 = 
      # ramp-capacity-foreground = ${colors.accent}
      # ramp-capacity-font = 5

      # animation-charging-0 = 
      # animation-charging-1 = 
      # animation-charging-2 = 
      # animation-charging-3 = 
      # animation-charging-4 = 
      # animation-charging-foreground = ${colors.accent}
      # animation-charging-font = 5
      # animation-charging-framerate = 750

      # animation-discharging-0 = 
      # animation-discharging-1 = 
      # animation-discharging-2 = 
      # animation-discharging-foreground = ${colors.accent}
      # animation-discharging-framerate = 750

      # [module/temperature]
      # type = internal/temperature
      # thermal-zone = 0
      # warn-temperature = 80

      # format = <ramp><label>
      # format-underline = #f50a4d
      # format-warn = <ramp><label-warn>
      # format-warn-prefix = 
      # format-warn-prefix-font = 5
      # format-warn-prefix-foreground = ${colors.accent}

      # format-prefix = " "
      # format-prefix-font = 5
      # format-prefix-foreground = ${colors.accent}

      # label = %temperature-c%
      # label-warn = %temperature-c%
      # label-warn-foreground = ${colors.secondary}

      # ramp-0 = 
      # ramp-1 = 
      # ramp-2 = 
      # ramp-foreground = ${colors.foreground-alt}

      # [module/powermenu]
      # type = custom/menu

      # expand-right = true

      # format-spacing = 1

      # label-open = 
      # label-open-foreground = ${colors.accent}
      # label-close =  cancel
      # label-close-foreground = ${colors.accent}
      # label-separator = |
      # label-separator-foreground = ${colors.foreground-alt}

      # menu-0-0 = logout
      # menu-0-0-exec = menu-open-1
      # menu-0-1 = reboot
      # menu-0-1-exec = menu-open-1
      # menu-0-2 = power off
      # menu-0-2-exec = menu-open-2

      # menu-1-0 = cancel
      # menu-1-0-exec = menu-open-0
      # menu-1-1 = reboot
      # menu-1-1-exec = sudo reboot

      # menu-2-0 = power off
      # menu-2-0-exec = sudo poweroff
      # menu-2-1 = cancel
      # menu-2-1-exec = menu-open-0

      # [settings]
      # screenchange-reload = true

      # [global/wm]
      # margin-top = 5
      # margin-bottom = 5
    };
    script = "";
  };
}

