{ inputs, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      # required tools
      unzip
      gnumake

      # Lua LSP
      lua-language-server
      stylua

      # Nix LSP
      nixd
      nixfmt-rfc-style
      deadnix
      statix

      # CPP LSP
      clang-tools

      # Rust LSP
      rust-analyzer
      clippy
      rustfmt

      # Python LSP
      pylyzer
      pyright
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
