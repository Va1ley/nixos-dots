{ config, lib, pkgs, ... }:

{
    # Networking
    time.timeZone = "America/Denver";
    networking.hostName = "nix-desktop";
    networking.firewall.enable = true;
    networking.networkmanager.enable = true;

    # Help Spotify Connect
    networking.firewall.allowedUDPPorts = [ 5353 ];

    # Bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;

        settings = {
            General.Experimental = true;
            General.FastConnectable = true;
        };
    };
    services.blueman.enable = true;

    # Sound
    security.rtkit.enable = true;
    services.pipewire = {
       enable = true;
       alsa.enable = true;
       alsa.support32Bit = true;
       pulse.enable = true;
    };
}
