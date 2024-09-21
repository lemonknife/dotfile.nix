{ lib, inputs, ... }:
{
  xdg.configFile."yazi/tokyonight_moon.tmTheme".source = "${inputs.tokyonight}/extras/sublime/tokyonight_moon.tmTheme";
  programs.yazi = {
    enable = true;
    theme = lib.mkMerge [
      (lib.importTOML "${inputs.tokyonight}/extras/yazi/tokyonight_moon.toml")
      { highlight = "./tokyonight_moon.tmTheme"; }
    ];
    plugins = {
      full-border = "${inputs.yazi-plugins}/full-border.yazi";
      git = "${inputs.yazi-plugins}/git.yazi";
    };
    initLua = ''
      require("full-border"):setup()
    '';
    enableFishIntegration = true;
  };
}
