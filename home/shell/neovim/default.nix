{ inputs, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
      unzip
      gnumake
      cmake
      clang
      clang-tools
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
