{
  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./terminal
    ./dev
  ];

  home.file."Pictures/Wallpapers".source = ./wallpaper;

  home.stateVersion = "24.11";
}
