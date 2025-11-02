{ pkgs, ... }:

{
    programs.dankMaterialShell = {
        enable = true;

        enableClipboard = true;
        enableVPN = true;
        enableBrightnessControl = true;
        enableSystemSound = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;

        default.settings = {
            theme = "dark";
            dynamicTheming = true;
            gtkTheme = "adw-gtk3-dark";
        };

        quickshell.package = pkgs.quickshell;
    };
}
