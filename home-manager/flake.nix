{
    description = "Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        dgop = {
            url = "github:AvengeMedia/dgop";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        dank-material-shell = {
            url = "github:AvengeMedia/DankMaterialShell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
    { self, nixpkgs, home-manager, dank-material-shell, ... }:
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
            dank-material-shell.homeModules.dankMaterialShell.default
        ];

        extraSpecialArgs = {
            inherit dank-material-shell;
        };
        };
    };
}
