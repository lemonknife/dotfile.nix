{ pkgs, ... }:
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
    };
    theme = "Tokyo Night Moon";
  };
}
