{ inputs, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
      unzip
      cmake
      gcc
      clang
      deadnix
      statix
    ];

    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
