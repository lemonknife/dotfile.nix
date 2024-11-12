{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./zen.nix
  ];

  home.packages = [
    pkgs.discord
  ];
}
