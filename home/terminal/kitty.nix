{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Cascadia Code PL";
      size = 15;
    };
    theme = "Tokyo Night Moon";
  };
}
