{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  icons = {
    extension = {
      markdown = "";
      md = "";
      readme = "";
    };
    name = {
      readme = "";
    };
  };
  yamlFormat = pkgs.formats.yaml { };
in
{
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  # Set fzf theme
  programs.fish.interactiveShellInit =
    builtins.readFile "${inputs.tokyonight}/extras/fzf/tokyonight_moon.sh"
    + "set -gx LS_COLORS $(vivid generate tokyonight-moon)";

  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      date = "relative";
      blocks = [
        "permission"
        "user"
        "size"
        "date"
        "git"
        "name"
      ];
    };
  };

  xdg.configFile."lsd/icons.yaml" = lib.mkIf (icons != { }) {
    source = yamlFormat.generate "lsd-icons" icons;
  };

  home.packages = with pkgs; [
    ouch
    vivid
  ];
}
