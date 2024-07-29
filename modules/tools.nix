{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    htop
    tldr
    ripgrep
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    # options = [ "--no-aliases" ];
  };

  programs.eza = {
    git = true;
    icons = true;
    enable = true;
    enableAliases = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.git = {
    enable = true;
    userName = "benvonh";
    userEmail = "benjaminvonsnarski@gmail.com";
  };

  programs.gh = {
    enable = true;
  };
}
