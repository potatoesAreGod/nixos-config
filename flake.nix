{
  inputs = {
    # NixOS official package source, using the nixos-23.11 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Home manager, for user config
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.homeserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        vars = import ./hosts/nixos/vars.nix;
      };
      modules = [
        # Base config
        ./configuration.nix
        ./hosts/nixos/default.nix

        # Local services
        ./modules/libreddit
        ./modules/samba
        ./containers/homeassistant

        # Host-accsessible services
        ./modules/vnstat

        # User config
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.user = import ./users/user/home.nix;
        }
      ];
    };
  };
}
