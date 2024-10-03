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
      taplo

      # Python LSP
      ruff
      ruff-lsp
      basedpyright
      python3Full

      # sqlite
      sqlite

      # Debugger
      vscode-extensions.vadimcn.vscode-lldb
      vscode-extensions.ms-python.debugpy
    ];

    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
  };

  xdg.configFile.nvim = {
    source = ./lmnvim;
    recursive = true;
  };

  # Add debugger
  xdg.configFile."nvim/lua/configs/rust.lua".text = ''
    local configs = function(opts)
      -- Update this path
      local extension_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/"
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb'
      local this_os = vim.uv.os_uname().sysname;

      liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

      local cfg = require('rustaceanvim.config')

      local config = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }

      return vim.tbl_deep_extend("force", config, opts or {})
    end

    return configs
  '';
}
