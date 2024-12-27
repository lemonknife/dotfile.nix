{
  description = "Lemonife's config";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    niri.url = "github:sodiboo/niri-flake";
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
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    tokyonight = {
      type = "github";
      owner = "folke";
      repo = "tokyonight.nvim";
      flake = false;
    };
    yazi-plugins = {
      type = "github";
      owner = "yazi-rs";
      repo = "plugins";
      flake = false;
    };
    starship-yazi = {
      type = "github";
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      flake = false;
    };
    fuse-archive-yazi = {
      type = "github";
      owner = "lemonknife";
      repo = "fuse-archive.yazi";
      flake = false;
    };
    fish-ssh-agent = {
      type = "github";
      owner = "danhper";
      repo = "fish-ssh-agent";
      flake = false;
    };
    fifc = {
      type = "github";
      owner = "gazorby";
      repo = "fifc";
      flake = false;
    };
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty-pkg = {
      url = "github:ghostty-org/ghostty";
    };
    ghostty.url = "github:clo4/ghostty-hm-module";
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-cosmic,
      rust-overlay,
      niri,
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

            inputs.agenix.nixosModules.default

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

            niri.nixosModules.niri
            {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
                niri.overlays.niri
                # (final: prev: {
                #   # Replace unstable package with stable version
                #   basedpyright = inputs.nixpkgs-nightly.legacyPackages.${prev.system}.basedpyright;
                #   ruff = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.ruff;
                #   yazi = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.yazi;
                # })
              ];
            }
          ];
        };
      };
    };
}
