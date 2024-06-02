{ config, vars, ... }:

let
  directories = [
    "${vars.configRoot}/homeassistant""
];
in
{
  virtualisation.oci-containers = {
    containers = {
      homeassistant = {
        image = "ghcr.io/home-assistant/home-assistant:stable";
        autoStart = true;
        volumes = [ "${vars.configRoot}/homeassistant:/config" ];
        environment = {
          TZ = vars.timeZone;
        };
        extraOptions = [
          "--network=host"
          "--device=/dev/ttyACM0:/dev/ttyACM0"
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
