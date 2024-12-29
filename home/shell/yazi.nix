{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  xdg.configFile."yazi/tokyonight_moon.tmTheme".source =
    "${inputs.tokyonight}/extras/sublime/tokyonight_moon.tmTheme";

  home.packages = with pkgs; [
    p7zip
    fuse-archive
  ];
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
      fuse-archive = "${inputs.fuse-archive-yazi}";
    };
    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("starship"):setup()
      require("fuse-archive"):setup()
    '';
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "l" ];
          run = "plugin fuse-archive --args=mount";
          desc = "Enter or Mount selected archive";
        }
        {
          on = [ "h" ];
          run = "plugin fuse-archive --args=unmount";
          desc = "Leave or Unmount selected archive";
        }
        {
          on = [ "t" ];
          run = "plugin fuse-archive --args=tab";
          desc = "Create a new tab with CWD or Compressed File Path";
        }
      ];
    };
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
