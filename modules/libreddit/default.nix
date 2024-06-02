{ config, pkgs, ... }:

{
  services.libreddit = {
    enable = true;
    port = 8080;
    openFirewall = true;
  };
}
