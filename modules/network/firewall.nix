{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowPing = true;
  };
}
