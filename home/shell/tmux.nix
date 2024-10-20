{ inputs, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    customPaneNavigationAndResize = true;
    prefix = "C-a";
    escapeTime = 0;
    reverseSplit = true;
    extraConfig = builtins.concatStringsSep "\n" [
      (builtins.readFile "${inputs.tokyonight}/extras/tmux/tokyonight_moon.tmux")
    ];
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-h"  # use C-h and C-Left
          set -g @vim_navigator_mapping_right "C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
        '';
      }
    ];
  };
}
