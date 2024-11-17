{ pkgs, lib, config, vars, ... }:

# Since the options configDir and dataDir won't work they have to be manually changed trough the web interface
# Set metadata to ${vars.configRoot}/jellyfin
# Set movies to ${vars.dataRoot}/media/movies
# Set shows to ${vars.dataRoot}/media/tv

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
