{ pkgs, ... }:

{
    home.packages = with pkgs; [
        kdePackages.breeze-icons
    ];

    gtk = {
        enable = true;

        theme = {
            name = "adw-gtk3:dark";
            package = pkgs.adw-gtk3;
        };

        iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
        };
    };

        home.sessionVariables = {
            GTK_THEME = "adw-gtk3:dark";
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "qt6ct";
            QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
        };

        programs.kitty = {
            enable = true;
            extraConfig = ''
                include dank-tabs.conf
                include dank-theme.conf
                background_opacity 0.8
                confirm_os_window_close 0
            '';
            font.name = "JetBrains Mono";
            font.size = 14;
            themeFile = "Catppuccin-Mocha";
            settings = {
                window_margin_width = 10;
                background_blur = 0;
            };

        };


        programs.zed-editor = {
        userSettings = {
            theme = {
                mode = "dark";
                light = "One Light";
                dark = "Ayu Dark";
            };
        };
    };
}
