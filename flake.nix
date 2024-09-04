{
  description = "Lemonife's config";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes.url = "github:vinceliuice/grub2-themes";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-cosmic,
      rust-overlay,
      ...
    }:
    {
      nixosConfigurations = {
        lemon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./host

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
              };

              home-manager.users.lemon = import ./home;
            }

            inputs.grub2-themes.nixosModules.default

            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default

            { nixpkgs.overlays = [ rust-overlay.overlays.default ]; }
          ];
        };
      };
    };
}
