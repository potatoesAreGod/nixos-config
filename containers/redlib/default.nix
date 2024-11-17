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
        image = "quay.io/redlib/redlib:latest";
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
