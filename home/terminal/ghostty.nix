{ pkgs, inputs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty-pkg.packages.${pkgs.system}.default;
    shellIntegration = {
      enable = false;
      enableFishIntegration = true;
    };
    settings = {
      theme = (inputs.tokyonight + "/extras/ghostty/tokyonight_moon");
      font-family = "CaskaydiaCove Nerd Font Propo";
      font-size = 15;
      background-opacity = 0.7;
      window-decoration = false;
      window-padding-x = "8,5";
      window-padding-y = "8,5";
      shell-integration = "fish";
      shell-integration-features = true;
      cursor-style = "block";
    };
  };
}
