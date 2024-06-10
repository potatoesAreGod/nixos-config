{ config, pkgs, lib, ... }:

{
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "sudo" "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEyYG14oAMvJetOad9IFVw8OLMs4ERZ7kbnuYdov3Jux ezra@computer.local" ];
  };
}
