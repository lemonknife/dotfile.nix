{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  fzf-opts = builtins.readFile "${inputs.tokyonight}/extras/fzf/tokyonight_moon.sh";
  lines = lib.strings.splitString "\n" fzf-opts;

  fzf-edited-opts = builtins.map (
    line:
    let
      trimmed-line = lib.strings.trim line;
    in
    if
      lib.strings.hasPrefix "--color=bg" trimmed-line && !lib.strings.hasPrefix "--color=bg+" trimmed-line
      || lib.strings.hasPrefix "--color=gutter" trimmed-line
    then
      builtins.substring 0 (builtins.stringLength line - 9) line + "-1"
    else
      line
  ) lines;

  fzf-transparent-bg = lib.strings.concatLines fzf-edited-opts;

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
    fzf-transparent-bg + "set -gx LS_COLORS $(vivid generate tokyonight-moon)";

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

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };

  xdg.configFile."lsd/icons.yaml" = lib.mkIf (icons != { }) {
    source = yamlFormat.generate "lsd-icons" icons;
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 36000;
    maxCacheTtl = 36000;
    defaultCacheTtlSsh = 36000;
    maxCacheTtlSsh = 36000;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry-qt}/bin/pinentry
    '';
  };

  home.packages = with pkgs; [
    ouch
    vivid
    gpg-tui
  ];
}
