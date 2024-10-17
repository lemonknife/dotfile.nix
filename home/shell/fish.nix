{ inputs, ... }:
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
    ];
  };
}
