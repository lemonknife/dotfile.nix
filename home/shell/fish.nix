{ inputs, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.concatStringsSep "\n" [
      (builtins.readFile "${inputs.tokyonight}/extras/fish/tokyonight_moon.fish")
      ''
        set fish_greeting

        # enable micromamba
        export MAMBA_ROOT_PREFIX=~/micromamba
        eval "$(micromamba shell hook -s fish)"
      ''
    ];
    plugins = [
      {
        name = "fish-ssh-agent";
        src = inputs.fish-ssh-agent;
      }
      {
        name = "fifc";
        src = inputs.fifc;
      }
    ];
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableIonIntegration = false;
    enableNushellIntegration = false;
  };

  xdg.configFile."eza/theme.yml".source = "${inputs.tokyonight}/extras/eza/tokyonight.yml";

  home.packages = [
    pkgs.file
    pkgs.chafa
    pkgs.hexyl
    pkgs.procs
    pkgs.broot
  ];
}
