{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    xremap.url = "github:xremap/nix-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        archimedes =
          let
            system = "x86_64-linux";
            pkgsUnstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              { nixpkgs.config.allowUnfree = true; }
              ./hosts/archimedes/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit pkgsUnstable; };
                home-manager.users.kkinugasa = import ./home.nix;
              }
            ];
            specialArgs = { inherit inputs; };
          };
      };
      # homeConfigurations = {
      #   kkinugasa = inputs.home-manager.lib.homeManagerConfiguration {
      #     pkgs = import inputs.nixpkgs {
      #       system = "x86_64-linux";
      #       config = {
      #         allowUnfree = true;
      #         # permittedInsecurePackages = [ "nix-2.15.3" ];
      #       };
      #     };
      #     extraSpecialArgs = { inherit inputs; };
      #     modules = [ ./home.nix ];
      #   };
      # };
    };
}
