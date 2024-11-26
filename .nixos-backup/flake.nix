{
  description = "My NixOS Configuration with Spicetify";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Adjust channel if needed
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

  outputs = { self, nixpkgs, catppuccin, spicetify-nix, nix-software-center }@inputs: {
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          # (import ./configuration.nix inputs)
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
      };
    };

    imports = [
      # For NixOS
      inputs.spicetify-nix.nixosModules.default
    ];
  };
}
