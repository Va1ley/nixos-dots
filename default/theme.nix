{ pkgs, ... }:

{
    home.sessionVariables = {
        GTK_THEME = "catppuccin-frappe-blue-standard";
    };

    gtk = {
      enable = true;
      theme.package = pkgs.catppuccin-gtk;
      theme.name = "catppuccin-frappe-blue-standard";
      iconTheme.name = "Adwaita";
      iconTheme.package = pkgs.adwaita-icon-theme;
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
            background_opacity 0.4
            confirm_os_window_close 0
        '';
    };

    programs.zed-editor = {
        userSettings = {
            theme = {
                mode = "dark";
                light = "One Light";
                dark = "Catppuccin Mocha";
            };
        };
    };
}
