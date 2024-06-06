{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  # Auto-clean of garbage and old logs
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = ["weekly"];

  boot.tmp.cleanOnBoot = true;
  services.cron.systemCronJobs = [
    "0 22 * * * root journalctl --vacuum-time=5d"
  ];

  # Auto-update
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flags = [
      "--update-input"
    ];
    dates = "02:00";
    rebootWindow.lower = "01:00";
    rebootWindow.upper = "05:00";
    randomizedDelaySec = "45min";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  system.stateVersion = "23.11";
}
