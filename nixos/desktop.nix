{ inputs, pkgs, config, ... }:

{
    # Nvidia Drivers
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
    };

    services.xserver.digimend.enable = true;
    hardware.opentabletdriver.enable = true;
    environment.systemPackages = with pkgs; [
        krita
        kdePackages.wacomtablet
        opentabletdriver
        pureref
        config.boot.kernelPackages.digimend
    ];
}
