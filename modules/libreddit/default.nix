{ config, pkgs, ... }:

{
    services.libreddit = {
        enable = true;
        port = 8080;
    };

    networking.firewall.allowedTCPPorts = [ 8080 ];
}
