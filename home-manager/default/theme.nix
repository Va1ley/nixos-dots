{ pkgs, ... }:

{
    home.packages = with pkgs; [
        gnome-themes-extra
    ];

    gtk = {
        enable = true;

        theme = {
            name = "Colloid";
            package = pkgs.colloid-gtk-theme;
        };

        iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
        };
    };

        home.sessionVariables = {
            GTK_THEME = "Colloid";
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "qt6ct";
            QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
        };

        programs.kitty = {
            enable = true;
            font.name = "JetBrains Mono";
            font.size = 14;
            themeFile = "Catppuccin-Mocha";
            settings = {
                window_margin_width = 10;
                background_blur = 0;
            };
            extraConfig = ''
                background_opacity 0.6
                confirm_os_window_close 0
                include dank-theme.conf
            '';
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
