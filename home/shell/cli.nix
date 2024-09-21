{ inputs, pkgs, ... }:
{
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  # Set fzf theme
  programs.fish.interactiveShellInit = builtins.readFile "${inputs.tokyonight}/extras/fzf/tokyonight_moon.sh";

  home.packages = with pkgs; [ ouch ];
}
