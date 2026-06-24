{ config, pkgs, dank-material-shell, ... }:

{
    imports = [
        ./default/imports.nix
        ./desktop/hyprland.nix
        ./dms.nix
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
                "x-scheme-handler/http"  = [ "floorp.desktop" ];
                "x-scheme-handler/https" = [ "floorp.desktop" ];
                "text/html" = [ "floorp.desktop" ];
            };
            associations.added = {
                "application/vnd.microsoft.portable-executable" = [ "wine.desktop" ];
                "application/x-msdownload" = [ "wine.desktop" ];
                "image/png" = [ "org.gnome.Loupe.desktop" ];
                "image/jpeg" = [ "org.gnome.Loupe.desktop" ];

                "x-scheme-handler/http" = [ "floorp.desktop" ];
                "x-scheme-handler/https" = [ "floorp.desktop" ];
                "x-scheme-handler/chrome" = [ "floorp.desktop" ];
                "text/html" = [ "floorp.desktop" ];
                "application/x-extension-htm" = [ "floorp.desktop" ];
                "application/x-extension-html" = [ "floorp.desktop" ];
                "application/x-extension-shtml" = [ "floorp.desktop" ];
                "application/xhtml+xml" = [ "floorp.desktop" ];
                "application/x-extension-xhtml" = [ "floorp.desktop" ];
                "application/x-extension-xht" = [ "floorp.desktop" ];
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
            nixbuild = "sudo nixos-rebuild switch --flake /home/emers/nix-configs && nixbackup";
            nixgarbage = "sudo nix-collect-garbage -d";
            nixupdate = "sudo nix-channel --update && nix flake update --flake /home/emers/nix-configs/ && nix flake update --flake /home/emers/.config/home-manager/ && nix flake archive ~/.config/home-manager/ && nixbackup";

            homebuild = "home-manager switch --flake ~/.config/home-manager#emers@host --impure";
            nixbackup = "cp ~/nix-configs/* ~/Documents/GitHub/nixos-dots/nixos/ -R && cp ~/.config/home-manager/* ~/Documents/GitHub/nixos-dots/home-manager -R";
            replay = "gpu-screen-recorder -w DP-6 -c mp4 -s 0x0 -f 60 -a default_output -a default_input -q very_high -r 300 -o ~/Videos/Replays/";
            # && cp ~/.config/DankMaterialShell/* ~/Documents/GitHub/nixos-dots/DankMaterialShell -R
        };
        bashrcExtra = ''
            if [ "$(tput cols)" -gt 71 ]; then
                fastfetch
            fi
        '';
    };

    services.udiskie = {
        enable = true;
        tray = "never";
        settings.program_options.file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
    };

    programs.zed-editor = {
    enable = true;
    userSettings = {
        # languages = {
        #     Rust = {
        #         show_inline_completions = true;
        #     };
        #     "Nix" = {
        #         "show_inline_completions" = false;
        #     };
        # };
        tab_size = 4;
        # outline_panel = {
        #   dock = "left";
        # };
        ui_font_size = 18;
        buffer_font_size = 18;
        format_on_save = "off";
    };
    };

  # Dont Change
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
