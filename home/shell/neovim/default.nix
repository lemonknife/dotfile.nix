{pkgs,...}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
      unzip
      cmake
      gcc
      clang
      nodejs
      deadnix
      statix
    ];
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
