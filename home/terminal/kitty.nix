{
  programs.kitty = {
    enable = true;
    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 15;
    };
    settings = {
      background_opacity = "0.9";
      font_features = "CaskaydiaCoveNF-Italic +ss01";
      # Edit background color in case kitty render neovim as transparent background 
      background = "#222437";
      window_padding_width = "8";
      hide_window_decorations = "yes";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      symbol_map = "U+15dc Noto Sans Canadian Aboriginal\nsymbol_map U+1d17 DejaVu Serif";
    };
    themeFile = "tokyo_night_moon";
  };
}
