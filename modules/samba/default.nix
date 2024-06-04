{ vars, config, lib, pkgs, ... }:

{
  # Create user for SMB, used by the family
  users.users.family = {
    isSystemUser = true;
    createHome = false;
    description = "smb user for family";
    group = "family";
  };
  users.groups.family = {};

  services = {
    samba = {
      package = pkgs.samba4Full;
      # ^^ `samba4Full` is compiled with avahi, ldap, AD etc support (compared to the default package, `samba`
      # Required for samba to register mDNS records for auto discovery 
      # See https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/top-level/all-packages.nix#L27268
      enable = true;
      openFirewall = true;

      # Directory to share
      shares.shared = {
        path = "${vars.sharedDir}";
        writable = "true";
      };
    };

    avahi = {
      publish.enable = true;
      publish.userServices = true;
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      enable = true;
      openFirewall = true;
    };

    samba-wsdd = {
    # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
      enable = false; # Don't have any windows devices currently
      openFirewall = true;
    };
  };
}
