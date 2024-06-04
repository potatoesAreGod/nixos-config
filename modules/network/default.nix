{ config, pkgs, lib, ... }:

{
  imports = [
    ./dns.nix
    ./firewall.nix
  ];

  networking = {
    hostName = "homeserver";

    # For auto-config of interfaces
    networkmanager = {
      enable = true;
    };
  };
}
