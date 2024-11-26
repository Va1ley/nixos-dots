{ pkgs, ... }:

{
    home.sessionVariables = {
        GTK_THEME = "Marwaita-Dark-Orange";
    };

    gtk = {
      enable = true;
      theme.package = pkgs.marwaita-orange;
      theme.name = "Marwaita-Dark-Orange";
      iconTheme.name = "Adwaita";
      iconTheme.package = pkgs.adwaita-icon-theme;
    };

    programs.kitty = {
        enable = true;
        font.name = "JetBrains Mono";
        font.size = 14;
        themeFile = "IC_Orange_PPL";
        settings = {
            window_margin_width = 10;
            background_blur = 0;
        };
        extraConfig = ''
            background_opacity 0.7
            confirm_os_window_close 0
        '';
    };

    programs.zed-editor = {
        userSettings = {
            theme = {
                mode = "dark";
                light = "One Light";
                dark = "Gruvbox Dark Hard";
            };
        };
    };
}
