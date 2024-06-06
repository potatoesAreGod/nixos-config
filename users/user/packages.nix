{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    git
    tree
    htop
    unzip
    unrar
    ripgrep
    wget
    curl
  ];
}
