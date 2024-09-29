{ config, ... }:
{
  programs.niri = {
    settings.binds = with config.lib.niri.actions; {
      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";

      "Mod+Space".action = spawn "fuzzel";

      "Mod+Shift+L".action = quit;

      "Mod+Return".action = spawn "kitty";
    };
  };

  programs.fuzzel.enable = true;
}
