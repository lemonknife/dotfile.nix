{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  importYaml =
    file:
    let
      json = pkgs.runCommand "converted.json" { } ''
        ${lib.getExe pkgs.yj} < ${file} > $out
      '';
    in
    builtins.fromJSON (builtins.readFile json);
in
{
  programs.git = {
    enable = true;
    userName = "Lemonife";
    userEmail = "lemonife@protonmail.com";
  };

  programs.lazygit = {
    enable = true;
    settings = importYaml "${inputs.tokyonight}/extras/lazygit/tokyonight_moon.yml";
  };
}