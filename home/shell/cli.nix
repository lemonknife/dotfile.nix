{ lib, inputs, ... }:
{
  programs.yazi = {
    enable = true;
    theme = lib.importTOML "${inputs.tokyonight}/extras/yazi/tokyonight_moon.toml";
  };
  programs.ripgrep.enable = true;
  programs.fd.enable = true;

  programs.fzf = {
    enable = true;
  };
  programs.fish.interactiveShellInit = builtins.readFile "${inputs.tokyonight}/extras/fzf/tokyonight_moon.sh";
}
