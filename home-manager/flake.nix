{
  description = "Home Manager flake for Emerson";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, dankMaterialShell, ... }:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations."emers@host" = home-manager.lib.homeManagerConfiguration {
        # Pull pkgs directly from nixpkgs input, *not* by re-importing
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = [
          ./home.nix
          dankMaterialShell.homeModules.dankMaterialShell.default
        ];

        extraSpecialArgs = {
          inherit dankMaterialShell;
        };
      };
    };
}
