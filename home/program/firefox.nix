{
  programs.firefox = {
    enable = true;
    languagePacks = [ "zh-CN" ];
    profiles.cirno = {
      name = "cirno";
      isDefault = true;
      search = {
        force = true;
        default = "Google";
        privateDefault = "DuckDuckGo";
        order = [
          "Google"
          "DuckDuckGo"
        ];
      };
      settings = {
        "sidebar.verticalTabs" = true;
      };
    };
  };
}
