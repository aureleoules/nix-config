{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "mononoki Bold Nerd Font Complete Mono";
      size = 10;
    };

    settings = {
      enabled_layouts = "grid";
      font_size = 10;
      window_padding_width = 4;
    };

    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+l" = "previous_window";
      "ctrl+shift+m" = "next_window";
    };
  };
}
