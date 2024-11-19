{ config, vars, ... }:

let
  directories = [
    "${vars.configRoot}/homeassistant"
  ];
in
{
  virtualisation.oci-containers = {
    containers = {
      redlib = {
        image = "quay.io/redlib/redlib@sha256:b51490603431eaab431fcfc86578e2e2ecb1d0318aeb3f421ad840ea3121d6b5";
        autoStart = true;
        ports = [ "8080:8080" ];
        extraOptions = [
          "--network=host"
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
