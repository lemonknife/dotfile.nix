{ pkgs, ... }:
{
  programs.fish = { 
    enable = true;
    interactiveShellInit = ''
      export EDITOR = "fish"
    '';
  };
}
