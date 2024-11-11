{ config, lib, pkgs, ... }:

{
    time.timeZone = "America/Denver";
    networking.hostName = "framework";
    networking.firewall.enable = true;
    networking.networkmanager.enable = true;

    # Help Spotify Connect
    networking.firewall.allowedUDPPorts = [ 5353 ];

    # Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    # A2DP Sync
    hardware.bluetooth.settings = {
        General = {
            Experimental = true;
            Enable = "Source,Sink,Media,Socket";
        };
    };

    # Backlight
    programs.light.enable = true;

    # Sound
    services.pipewire = {
       enable = true;
       pulse.enable = true;
    };

    # Printing
    services.printing.enable = true;
    services.printing.drivers = [ pkgs.brlaser ];

    # Fingerprint
    # sudo fprintd-enroll user # to enroll
    # sudo fprintd-verify # to verify!
    services.fprintd.enable = true;
    security.pam.services = {
        hyprlock.fprintAuth = true;
        sddm.fprintAuth = true;
        login.fprintAuth = true;
        sudo.fprintAuth = true;
    };

    # Power Button
    services.logind.extraConfig = ''
      HandlePowerKey=suspend
    '';
}
