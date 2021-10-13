{
  description = "NixOS system configuration";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Used for Firefox addons
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, rust-overlay, agenix, nur, ... }:
    let
      baseCfg = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/default.nix
            home-manager.nixosModules.home-manager
            host
            {
              nixpkgs.overlays = [
                rust-overlay.overlay
                agenix.overlay
                nur.overlay
              ];
            }
            agenix.nixosModules.age
          ];
        };
    in {
      nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host;
        value = baseCfg (./hosts/. + "/${host}");
      }) [ "aura" "carbide" "nuc" ]);
    };
}
