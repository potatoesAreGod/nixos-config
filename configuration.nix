{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 3000 8080 8081 8123 9001 9030 ];
    allowedUDPPorts = [];
    allowPing = false;
  };

#  time.timeZone = "Europe/Stockholm";
#  i18n.defaultLocale = "en_US.UTF-8";

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "sudo" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    wget
    htop
    git
    curl
  ];
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  nix.gc = {
    automatic = true;
    dates  = "23:00";
    persistent = true;
    options = "--delete-older-than 5d";
  };
  boot.tmp.cleanOnBoot = true;
  services.cron.systemCronJobs = [
    "0 22 * * * root journalctl --vacuum-time=5d"
  ];

  # Various services
  services.libreddit = {
    enable = true;
    port = 8080;
  };

  services.vnstat = {
    enable = true;
  };

#  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
#  system.stateVersion = "23.11"; # Did you read the comment?

}
