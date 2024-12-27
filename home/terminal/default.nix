{ pkgs, ... }:
{
  imports = [
    ./wez
    ./ghostty.nix
    ./kitty.nix
  ];
}
