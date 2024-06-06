{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";

  programs.git = {
    enable = true;
    userName = "potatoesAreGod";
    userEmail = "118043038+potatoesAreGod@users.noreply.github.com";
    extraConfig = {
      core = {
        sshCommand = "ssh -o 'IdentitiesOnly=yes' -i ~/.ssh/git_ed25519";
      };
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
