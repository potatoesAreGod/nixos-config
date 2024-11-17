{
  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager, for user config
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.homeserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        vars = import ./hosts/nixos/vars.nix;
        inherit inputs;
      };
      modules = [
        # Base config
        ./modules/network/default.nix
        ./hosts/nixos/default.nix

        # Services services
        ./modules/samba
        ./modules/jellyfin
        ./modules/tor/relay

        # Docker containers
        ./containers/homeassistant
        ./containers/redlib

        # User config
        ./users/user
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.user = import ./users/user/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
