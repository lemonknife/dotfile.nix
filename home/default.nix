{
  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./terminal
  ];

  home.stateVersion = "24.11";
}
