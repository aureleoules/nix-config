{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [ ];
      fonts = [ "mononoki Nerd Font 11" ];

      window.border = 0;
      focus.followMouse = false;
      focus.mouseWarping = false;

      gaps = {
        inner = 15;
        outer = 15;
        smartGaps = true;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "XF86AudioPlay" = "exec playerctl play";
        "XF86AudioPause" = "exec playerctl pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "${modifier}+n" = "exec --no-startup-id ${pkgs.writeShellScriptBin "new-workspace" ''
#!/bin/sh
WS_JSON=$(i3-msg -t get_workspaces)
for i in {1..10} ; do
    if [[ ! $WS_JSON =~ \"num\":\ ?$i ]] ; then
        i3-msg workspace number "$i"
        break
    fi
done            
''}/bin/new-workspace";
        "${modifier}+Shift+n" = "exec --no-startup-id ${pkgs.writeShellScriptBin "move-new-workspace" ''
#!/bin/sh
WS_JSON=$(i3-msg -t get_workspaces)
for i in {1..10} ; do
    if [[ ! $WS_JSON =~ \"num\":\ ?$i ]] ; then
        i3-msg move container to workspace number "$i"
        break
    fi
done            
''}/bin/move-new-workspace";
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi drun -show drun";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+Shift+p" = "exec flameshot gui";
        "${modifier}+r" = "mode resize";
        "${modifier}+Tab" = "workspace next_on_output";
        "Mod1+Tab" = "workspace next";
        "Mod1+Shift+Tab" = "workspace prev";
      };

      startup = [
        {
          command = "nitrogen --restore";
          always = true;
          notification = false;
        }
        {
          command = "flameshot";
          always = true;
          notification = false;
        }
        {
          command = "imwheel";
          always = true;
          notification = false;
        }
        {
          command = "feh --bg-scale ~/config/wallpaper.jpg";
          always = true;
          notification = false;
        }
        {
          command = "xset r rate 180 30";
          always = true;
          notification = false;
        }
        {
          command = "xrandr --output DP-0 --off --output DP-1 --off --output DP-2 --primary --rate 144.00 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-3 --off --output HDMI-0 --mode 1920x1080 --pos 3840x0 --rotate normal --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal";
          always = true;
          notification = false;
        }
        {
          command = "xinput set-prop 10 'libinput Middle Emulation Enabled' 0";
          always = true;
          notification = false;
        }
        {
          command = builtins.toString
            (pkgs.writeScriptBin "start-polybar" ''
              pkill polybar
              killall -q polybar
              while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
              for m in $(polybar --list-monitors | cut -d":" -f1); do
                MONITOR=$m polybar -q -r main &
              done
            '') + "/bin/start-polybar";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
