{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 3000 8081 8123 9001 9030 ];
    allowedUDPPorts = [];
    allowPing = false;
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "sudo" "wheel" ];
  };
}
