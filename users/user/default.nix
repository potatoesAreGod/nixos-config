{ config, pkgs, lib, ... }:

{
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "sudo" "wheel" ];
  };
}
