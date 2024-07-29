{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.tmux
    outputs.homeManagerModules.tools
    outputs.homeManagerModules.neovim
  ];

  nixpkgs = {
    config = {
      allowUnfree = false;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    stateVersion = "23.11";
    packages = with pkgs; [
      vlc
      brave
      discord
      neovide
      mission-center
    ];
  };

  # systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
}
