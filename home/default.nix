{ lib, inputs, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./terminal
    ./dev
    ./niri.nix
    ./program
    inputs.agenix.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  age.secrets.gitconfig.file = ../secret/gitconfig-secret.age;
  age.secretsDir = "/run/agenix";
  age.secretsMountPoint = "/run/agenix.d";

  catppuccin = {
    flavor = "mocha";
    pointerCursor = {
      enable = true;
      accent = "dark";
    };
  };

  gtk.catppuccin = {
    enable = true;
    accent = "dark";
    icon = {
      enable = true;
      accent = "dark";
    };
  };

  # Create symlink for wallpapers
  home.file."Pictures/Wallpapers".source = ./wallpaper;

  home.stateVersion = "24.11";
}
