{
  description = "The Best. NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Adjust channel if needed
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell";
    dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, spicetify-nix, dankMaterialShell }@inputs:
    {
      nixosConfigurations = {
        nix-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            dankMaterialShell.nixosModules.greeter
          ];
        };
      };

      imports = [
        # For NixOS
        inputs.spicetify-nix.nixosModules.default
      ];
    };
}
