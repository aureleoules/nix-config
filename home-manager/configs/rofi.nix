{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = builtins.toString (pkgs.writeText "rofi-theme" ''
      * {
          selected-normal-foreground:  @lightfg;
          foreground:                  rgba ( 196, 202, 212, 100 % );
          normal-foreground:           @foreground;
          alternate-normal-background: rgba ( 42, 42, 42, 100 % );
          red:                         rgba ( 194, 65, 65, 100 % );
          selected-urgent-foreground:  @lightfg;
          blue:                        rgba ( 43, 131, 166, 100 % );
          urgent-foreground:           @lightfg;
          alternate-urgent-background: @red;
          active-foreground:           @lightfg;
          lightbg:                     @foreground;
          selected-active-foreground:  @lightfg;
          alternate-active-background: @blue;
          background:                  rgba(17, 17, 17, 100%);
          alternate-normal-foreground: @foreground;
          normal-background:           @background;
          lightfg:                     rgba ( 249, 249, 249, 100 % );
          selected-normal-background:  @selected-active-background;
          border-color:                @foreground;
          spacing:                     2;
          separatorcolor:              rgba ( 183, 183, 183, 100 % );
          urgent-background:           @red;
          selected-urgent-background:  rgba ( 214, 78, 78, 100 % );
          alternate-urgent-foreground: @urgent-foreground;
          background-color:            rgba ( 0, 0, 0, 0 % );
          alternate-active-foreground: @active-foreground;
          active-background:           @blue;
          selected-active-background:  #4bc98a;
      }
      window {
          background-color: @background;
          border:           2px;
          width:            50%;
          height:           50%;
          anchor:           north;
          y-offset:         -25%;

          border-color:     @selected-active-background;
          padding:          30px;
      }
      mainbox {
          border:  0;
          padding: 0;
      }
      message {
          border:       2px dash 0px 0px;
          border-color: @separatorcolor;
          padding:      1px;
      }
      textbox {
          text-color: @foreground;
      }
      listview {
          fixed-height: 0;
          border:       0;
          border-color: @separatorcolor;
          spacing:      0;
          scrollbar:    true;
          padding:      2px 0px 0px;
      }
      element {
          border:  0;
          padding: 10px;
      }
      element normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      element normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      element normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      element selected.normal {
          background-color: @selected-normal-background;
          text-color:       @background;
      }
      element selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      element selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      element alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      element alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      element alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      scrollbar {
          width:        4px;
          border:       0;
          handle-color: rgba ( 85, 85, 85, 100 % );
          handle-width: 8px;
          padding:      0;
      }
      mode-switcher {
          border:       2px dash 0px 0px;
          border-color: @separatorcolor;
      }
      button {
          spacing:    0;
          text-color: @normal-foreground;
      }
      button selected {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      inputbar {
          spacing:    0px;
          text-color: @normal-foreground;
          padding:    1px;
          children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
      }
      case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
      }
      entry {
          spacing:    0;
          text-color: @normal-foreground;
      }
      prompt {
          spacing:    0;
          text-color: @normal-foreground;
      }
      textbox-prompt-colon {
          expand:     false;
          str:        ":";
          margin:     0px 0.3000em 0.0000em 0.0000em;
          text-color: inherit;
      }
    '');
  };
}
