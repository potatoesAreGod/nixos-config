{ vars, inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "${vars.timeZone}";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  settings.experimental-features = [ "nix-command" "flakes" ];
  };

  boot.tmp.cleanOnBoot = true;
  services.cron.systemCronJobs = [
    "0 22 * * * root journalctl --vacuum-time=7d"
  ];

  # Auto-update
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  nixpkgs.config.allowUnfree = true;

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
