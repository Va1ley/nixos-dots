{ config, lib, pkgs, inputs, ... }:

{
    imports = [
        ./applications.nix
        ./desktop.nix
        ./hardware.nix
        ./hardware-configuration.nix
        ./spicetify.nix
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

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        jetbrains-mono
        emojione
        noto-fonts-cjk-sans
	    takao
		kochi-substitute
		roboto
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    system.stateVersion = "25.05"; # DO NOT CHANGE THIS EVER FR
}
