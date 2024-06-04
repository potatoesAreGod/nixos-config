{ config, pkgs, ... }:

{
  services.tor = {
    enable = true;
    openFirewall = true;
    settings = {
      ContactInfo = "";
      Nickname = "potato";
      DirPort = 9030;
      ORPort = 9001;
      SocksPort = 0;
      ExitPolicy = "reject *:*";
      HardwareAccel = 1;
      RelayBandwidthBurst  = "20 MB";
      RelayBandwidthRate = "10 MB";
   };

  # Enable relaying of traffic
   relay = {
     enable = true;
     role = "relay";
   };
  };
}
