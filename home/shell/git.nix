{
  config,
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
    userName = "lemonknife";
    userEmail = "lemonife@protonmail.com";
    includes = [ { path = config.age.secrets.gitconfig.path; } ];
  };

  programs.lazygit = {
    enable = true;
    settings = importYaml "${inputs.tokyonight}/extras/lazygit/tokyonight_moon.yml";
  };
}
