{ pkgs, ... }:

{
    imports = [
        ./default/imports.nix
    ];

    home = {
        username = "emers";
        homeDirectory = "/home/emers";
        sessionVariables = {
            EDITOR = "zed";
        };
        pointerCursor = {
            package = pkgs.vanilla-dmz;
            name = "Vanilla-DMZ";
            size = 24;
            gtk.enable = true;
            x11 = {
                enable = true;
                defaultCursor = true;
            };
        };
    };

    xdg = {
        enable = true;
        mimeApps = {
            enable = true;
            defaultApplications = {
                "text/plain" = [ "zed.desktop" ];
                "video/*" = [ "mpv.desktop" ];
                "image/png" = [ "Loupe.desktop" ];
                "image/jpeg" = [ "Loupe.desktop" ];
            };
            associations.added = {
                "application/vnd.microsoft.portable-executable" = [ "wine.desktop"];
                "application/x-msdownload" = [ "wine.desktop" ];
                "image/png" = [ "org.gnome.Loupe.desktop"];
                "image/jpeg" = [ "org.gnome.Loupe.desktop"];

                "x-scheme-handler/http" = [ "floorp.desktop" ];
                "x-scheme-handler/https" = [ "floorp.desktop" ];
                "x-scheme-handler/chrome"= [ "floorp.desktop" ];
                "text/html"=[ "floorp.desktop" ];
                "application/x-extension-htm"= [ "floorp.desktop" ];
                "application/x-extension-html"= [ "floorp.desktop" ];
                "application/x-extension-shtml"= [ "floorp.desktop" ];
                "application/xhtml+xml"= [ "floorp.desktop" ];
                "application/x-extension-xhtml"= [ "floorp.desktop" ];
                "application/x-extension-xht"= [ "floorp.desktop" ];
            };
        };
        userDirs = {
            enable = true;
            createDirectories = false;
        };
    };

    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            ls = "ls --color=auto";
            grep = "grep --color=auto";
            nixedit = "zeditor ~/nix-configs/configuration.nix";
            nixbuild = "sudo nixos-rebuild switch --flake /home/emers/nix-configs && cp /home/emers/nix-configs/* /home/emers/.config/home-manager/.nixos-backup/ -R";
            nixgarbage = "sudo nix-collect-garbage -d";
            nixupdate = "sudo nix-channel --update && nix flake update --flake /home/emers/nix-configs/";
        };
        bashrcExtra = ''
            if [ "$(tput cols)" -gt 71 ]; then
                fastfetch
            fi
        '';
    };

    services.hypridle = {
        enable = true;
        settings = {
            lock_cmd = "hyprlock";
            before_sleep_cmd = "hyprlock";
            # ignore_dbus_inhibit = false;
            # ignore_systemd_inhibit = false;
        };
    };

    # Dont Change
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
