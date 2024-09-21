{ inputs, pkgs, ... }:
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
      icons = {
        extension = {
          markdown = "";
          md = "";
        };
      };
    };
  };

  home.packages = with pkgs; [
    ouch
    vivid
  ];
}
