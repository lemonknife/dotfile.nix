{ lib, inputs, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./terminal
    ./dev
    inputs.agenix.homeManagerModules.default
  ];

  age.secrets.gitconfig.file = ../secret/gitconfig-secret.age;
  age.secretsDir = "/run/agenix";
  age.secretsMountPoint = "/run/agenix.d";

  home.file."Pictures/Wallpapers".source = ./wallpaper;

  home.stateVersion = "24.11";
}
