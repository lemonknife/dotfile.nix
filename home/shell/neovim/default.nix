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
      taplo

      # Python LSP
      ruff
      ruff-lsp
      basedpyright
      python3Full
    ];

    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
  };

  xdg.configFile.nvim = {
    source = ./lmnvim;
    recursive = true;
  };
}
