{ config, ... }:
let
  p10k = "${config.home.homeDirectory}/flake/external/p10k.zsh";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    defaultKeymap = "emacs";
    initExtra = "source ${p10k}";
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    shellAliases = {
      cd = "z";
      ga = "git add";
      gd = "git diff";
      gc = "git commit";
      gs = "git status";
      gp = "git pull && git push";
      hms = "home-manager switch --flake ~/flake";
      ngc = "nix-collect-garbage -d";
    };
    history = {
      ignoreAllDups = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    zplug = {
      enable = true;
      zplugHome = "${config.xdg.dataHome}/zplug";
      plugins = [
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }
      ];
    };
  };
}
