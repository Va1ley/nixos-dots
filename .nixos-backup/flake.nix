{
  description = "The Best? NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Adjust channel if needed
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, catppuccin, spicetify-nix }@inputs: {
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
