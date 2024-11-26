{ pkgs, ... }:

{
    imports = [
        ./roxy/imports.nix
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
        };
    };

    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                modules-left = [
                    "hyprland/workspaces"
                    "network"
                    "bluetooth"
                    "tray"
                ];
                modules-center = [
                    "hyprland/window"
                ];
                modules-right = [
                    "group/backlight"
                    "group/audio"
                    "battery"
                    "clock"
                ];

                "hyprland/workspaces" = {
                    format = "{icon}";
                    format-icons = {
                        "1" = "一";
                        "2" = "二";
                        "3" = "三";
                        "4" = "四";
                        "5" = "五";
                        "6" = "六";
                        "7" = "七";
                        "8" = "八";
                        "9" = "九";
                        "10" = "十";
                    };
                };
                "network" = {
                    interface = "wlp170s0";
                    format = "{ifname}";
                    format-wifi = "  {essid}";
                    format-ethernet = "󰈀  {essid}";
                    format-disconnected = "切断";
                    tooltip-format-wifi = "{essid} {signalStrength}% ";
                    on-click = "nm-connection-editor";
                };
                "bluetooth" = {
                    format = "";
                    format-off = "{status}";
                    format-connected = "{device_alias} | {num_connections}";
                    tooltip-format = "{device_enumerate}";
                    tooltip-format-off = "{device_enumerate}";
                    tooltip-format-on = "{device_enumerate}";
                    tooltip-format-connected = "{device_enumerate}";
                    on-click = "blueman-manager";
                };
                "tray" = {
                    icon-size = 18;
                    spacing = 10;
                };

                "hyprland/window" = {
                    format = "{title}";
                };

                "battery" = {
                    interval = 30;
                    states = {
                        good = 95;
                        warning = 30;
                        critical = 10;
                    };
                    format = "{icon}  {capacity}%";
                    format-charging = "  {capacity}%";
                    format-plugged = "  {capacity}%";
                    format-alt = "{time}  {icon}";
                    format-icons = [ "" "" "" "" "" ];
                };
                "group/backlight" = {
                    orientation = "horizontal";
                    modules = [
                        "backlight"
                        "backlight/slider"
                    ];
                };
                "backlight" = {
                    format = "  {}%";
                    tooltip = false;
                    interval = 1;
                    on-scroll-up = "light -A 1";
                    on-scroll-down = "light -U 1";
                };
                "backlight/slider" = {
                    "min" = 0;
                    "max" = 100;
                    "orientation" = "horizontal";
                };
                "group/audio" = {
                    scroll-step = 1;
                    orientation = "horizontal";
                    modules = [
                        "pulseaudio"
                        "pulseaudio/slider"
                    ];
                };
                "pulseaudio" = {
                    tooltip = true;
                    scroll-step = 1;
                    format = "{icon}  {volume}%";
                    on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                    format-icons = {
                        default = [ "󰝟" "" "" ];
                    };
                };
                "pulseaudio/slider" = {
                    "min" = 0;
                    "max" = 100;
                    "orientation" = "horizontal";
                };
                "clock" = {
                    interval = 60;
                    format = "  {:%H:%M}";
                    format-alt = "  {:%Y-%m-%d}";
                    tooltip-format = "<tt><small>{:%A, %B %d, %Y (%R)}</small></tt>";
                };
            };
        };
    };

    programs.zed-editor = {
        enable = true;
        userSettings = {
            assistant = {
                default_model = {
                    provider = "copilot_chat";
                    model = "gpt-4o";
                };
                version = 2;
            };
            languages = {
                Rust = {
                    show_inline_completions = true;
                };
                "Nix" = {
                    "show_inline_completions" = false;
                };
            };
            tab_size = 4;
            outline_panel = {
                dock = "left";
            };
            ui_font_size = 20;
            buffer_font_size = 20;
            format_on_save = "off";
        };
    };

    wayland.windowManager.hyprland = {
        extraConfig = ''
            monitor=,preferred,auto,1

            $terminal = kitty
            $fileManager = thunar
            $menu = ulauncher-toggle

            exec-once = udiskie & fcitx & hypridle
            exec-once = nm-applet --indicator & ulauncher & fcitx5
            exec-once=/usr/lib/polkit-kde-authentication-agent-1

            decoration {
                rounding = 10
                active_opacity = 1.0
                inactive_opacity = 1.0
                blur {
                    enabled = true
                    size = 2
                    passes = 2
                    vibrancy = 0.1696
                }
            }

            xwayland {
                force_zero_scaling = true
            }

            animations {
                enabled = true
                bezier = myBezier, 0.05, 0.9, 0.1, 1.05
                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            dwindle {
                pseudotile = true
                preserve_split = true
            }

            misc {
                force_default_wallpaper = -1
                disable_hyprland_logo = false
            }

            cursor {
                hide_on_key_press = true
            }

            input {
                kb_layout = us
                follow_mouse = 1
                sensitivity = 0
                touchpad {
                    natural_scroll = false
                }
            }

            gestures {
                workspace_swipe = true
            }

            $mainMod = SUPER

            bind = $mainMod, Q, exec, $terminal
            bind = $mainMod, C, killactive,
            bind = $mainMod, M, exec, wlogout --protocol layer-shell
            bind = $mainMod, E, exec, $fileManager
            bind = $mainMod, V, togglefloating,
            bind = ALT, SPACE, exec, $menu
            bind = $mainMod, P, pseudo,
            bind = $mainMod, J, togglesplit,
            bind = $mainMod, F, exec, floorp
            bind = $mainMod SHIFT, B, exec, hyprshot -m region -o ~/Pictures
            bind = $mainMod, L, exec, hyprlock
            bind = $mainMod, O, fullscreen, 0
            bind = $mainMod, left, movefocus, l
            bind = $mainMod, right, movefocus, r
            bind = $mainMod, up, movefocus, u
            bind = $mainMod, down, movefocus, d
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10
            bind = $mainMod, S, togglespecialworkspace, magic
            bind = $mainMod SHIFT, S, movetoworkspace, special:magic
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod SHIFT, mouse:272, resizewindow
            windowrulev2 = opacity 0.85 0.85,class:^(dev.zed.Zed)$

            windowrulev2 = suppressevent maximize, class:.*
            windowrulev2 = opacity 0.98 0.98, class:^(floorp)$
            windowrulev2 = opacity 0.8 0.8, class:^(YouTube Music)$
            windowrulev2 = noborder, class:^(wofi)$

            bindle=, XF86AudioRaiseVolume, exec, pamixer -i 5
            bindle=, XF86AudioLowerVolume, exec, pamixer -d 5
            bindle=, XF86MonBrightnessUp, exec, light -A 5
            bindle=, XF86MonBrightnessDown, exec, light -U 5

            bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            bindl=, XF86AudioPlay, exec, playerctl play-pause
            bindl=, XF86AudioNext, exec, playerctl next
            bindl=, XF86AudioPrev, exec, playerctl previous

        '';
    };

    # Dont Change
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
