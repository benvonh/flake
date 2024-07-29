{ pkgs, ... }:
{
  programs.tmux = {
    mouse = true;
    enable = true;
    clock24 = true;
    shortcut = "s";
    extraConfig = ''
      set -g status-position top
      set-option -sg escape-time 10
      set-option -g default-terminal "screen-256color"
    '';
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];
  };
}
