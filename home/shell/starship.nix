{ lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "[](#a3aed2)"
        "[ ](bg:#a3aed2 fg:#769ff0)"
        "$username"
        "[ ](bg:#769ff0 fg:#a3aed2)"
        "$directory"
        "[ ](fg:#769ff0 bg:#394260)"
        "$git_branch"
        "$git_status"
        "[ ](fg:#394260 bg:#212736)"
        "$c"
        "$lua"
        "$java"
        "$nix_shell"
        "$nodejs"
        "$rust"
        "$golang"
        "$php"
        "$python"
        "[ ](fg:#212736)"
        ''

          $character''
      ];
      directory = {
        style = "fg:#e3e5e5 bg:#769ff0";
        read_only = "󰌾";
        format = "[$path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙";
          "Downloads" = "";
          "Music" = "";
          "Pictures" = "";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = "[[$symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };
      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
      };
      aws = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      buf = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      c = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      conda = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      crystal = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      dart = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      docker_context = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      elixir = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      elm = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      fennel = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      fossil_branch = {
        symbol = " ";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      guix_shell = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      haskell = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      haxe = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      hg_branch = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      hostname = {
        ssh_symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      java = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      julia = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      kotlin = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      lua = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      memory_usage = {
        symbol = "󰍛";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      meson = {
        symbol = "󰔷";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      nim = {
        symbol = "󰆥";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      nix_shell = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      nodejs = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      ocaml = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      package = {
        symbol = "󰏗";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      perl = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      php = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      pijul_channel = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      python = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      rlang = {
        symbol = "󰟔";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      ruby = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      scala = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      swift = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      username = {
        style_user = "bg:#a3aed2";
        format = "[[$user ](fg:#394260 bg:#a3aed2)]($style)";
        show_always = true;
      };
      zig = {
        symbol = "";
        style = "bg:#212736";
        format = "[[$symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1d2230";
        format = "[[ $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
    };
  };
}
