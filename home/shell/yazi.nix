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
      starship = "${inputs.starship-yazi}";
    };
    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("starship"):setup()
    '';
    settings = {
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };
    enableFishIntegration = true;
  };
}
