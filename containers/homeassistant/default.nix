{ config, vars, ... }:

let
  directories = [
    "${vars.configRoot}/homeassistant"
  ];
in
{
  virtualisation.oci-containers = {
    containers = {
      homeassistant = {
        image = "ghcr.io/home-assistant/home-assistant@sha256:2ddb0ceb186218e6daf423ac26be2e5a6ce1cd430c6064fe82d1d3d70b95cf38";
        autoStart = true;
        volumes = [ "${vars.configRoot}/homeassistant:/config" ];
        environment = {
          TZ = vars.timeZone;
        };
        extraOptions = [
          "--network=host"
          "--device=/dev/ttyACM0:/dev/ttyACM0" # zigbee controller
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
