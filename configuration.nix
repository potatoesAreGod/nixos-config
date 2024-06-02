{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hosts/nixos/hardware-configuration.nix
    ];

  # Networking
  networking.hostName = "homeserver";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 3000 ];
    allowedUDPPorts = [];
    allowPing = true;
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "sudo" "wheel" ];
  };
}
