{ inputs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile "${inputs.tokyonight}/extras/fish/tokyonight_moon.fish";
  };
}
