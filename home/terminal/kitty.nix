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
    };
    theme = "Tokyo Night Moon";
  };
}
