{
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";

  imports = [
    ./shell
    ./terminal
  ];
}
