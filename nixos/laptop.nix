{ config, lib, pkgs, ... }:

{
    # Printing
    services.printing.enable = true;
    services.printing.drivers = [
        pkgs.brlaser
        pkgs.cups-brother-hl3170cdw
    ];

    # Fingerprint
    # sudo fprintd-enroll user # to enroll
    # sudo fprintd-verify # to verify!
    services.fprintd.enable = true;
    security.pam.services = {
        # hyprlock.fprintAuth = true;
        # sddm.fprintAuth = true;
        # login.fprintAuth = true;
        sudo.fprintAuth = true;
    };

    # Backlight
    programs.light.enable = true;

    # Attempt to save battery
    networking.networkmanager.wifi.powersave = true;
    services.auto-auto-cpufreq.enable = true;
    powerManagement.enable = true;

    environment.systemPackages = with pkgs; [
        firefox
    ];
}
