{ config, lib, pkgs, ... }:

{
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

    # Backlight
    programs.light.enable = true;
}
