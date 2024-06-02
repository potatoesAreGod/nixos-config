{ config, pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.packages = with pkgs; [
    tree
  ];

  programs.git = {
    enable = true;
    userName = "potatoesAreGod";
    userEmail = "";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
