{ inputs, pkgs, ... }:

{
    imports = [
        ./applications.nix
        ./desktop.nix
        ./hardware.nix
        ./hardware-configuration.nix
        ./spicetify.nix
        ./japanese.nix
        inputs.spicetify-nix.nixosModules.default
    ];

    programs.hyprland.enable = true;

    users.users.emers = {
       isNormalUser = true;
       extraGroups = [
           	"wheel"
           	"networkmanager"
           	"video"
       ];
    };

    nix.settings.experimental-features = [ "nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
    nix.settings.auto-optimise-store = true;

    fonts = {
        packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            jetbrains-mono
            noto-fonts-color-emoji
    		roboto
    		material-symbols
            inter
        ];
    };


    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";

        theme = pkgs.stdenv.mkDerivation {
            name = "ina-grub";
            src = ./grub-theme/ina-grub;
            installPhase = ''
                mkdir -p $out
                cp -r * $out/
            '';
        };
    };

    boot.loader.efi.canTouchEfiVariables = true;
    system.stateVersion = "25.05"; # DO NOT CHANGE THIS EVER FR
}
