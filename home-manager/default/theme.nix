{ pkgs, ... }:

{

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark"; # Or another installed dark GTK theme
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita"; # Optional but matches dark theme well
      package = pkgs.adwaita-icon-theme;
    };

  };

  # Optional: Apply dark theme hint globally for apps that support it
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';

  # Optional: set environment variable for apps like Electron, Qt, etc.
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "adwaita-dark"; # for Qt apps
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
      include dank-theme.conf
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
