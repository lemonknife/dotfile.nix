{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  xdg.configFile."yazi/tokyonight_moon.tmTheme".source = "${inputs.tokyonight}/extras/sublime/tokyonight_moon.tmTheme";
  programs.yazi = {
    enable = true;
    theme = lib.mkMerge [
      (lib.importTOML "${inputs.tokyonight}/extras/yazi/tokyonight_moon.toml")
      { highlight = "./tokyonight_moon.tmTheme"; }
    ];
    enableFishIntegration = true;
  };

  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  # Set fzf theme
  programs.fish.interactiveShellInit = builtins.readFile "${inputs.tokyonight}/extras/fzf/tokyonight_moon.sh";

  home.packages = with pkgs; [ ouch ];
}
