{ config, inputs, pkgs, agenix, ... }:

let user = "user";
    keys = [ "" ]; in
{
  #imports = [
  #  ../../modules/nixos/secrets.nix
  #];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
      efi.canTouchEfiVariables = true;
    };
    #initrd.availableKernelModules = [ "" ];
  };

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

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
