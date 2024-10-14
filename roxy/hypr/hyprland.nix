{
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = ''
            source=~/.config/home-manager/default/hypr/mocha.conf

            monitor=,preferred,auto,1

            $terminal = kitty
            $fileManager = thunar
            $menu = ulauncher-toggle

            exec-once = udiskie & fcitx & hypridle
            exec-once = swaybg -i ~/.config/home-manager/roxy/hypr/wallpaper.jpg -m fill & waybar & dunst
            exec-once = nm-applet --indicator & ulauncher & fcitx5
            exec-once=/usr/lib/polkit-kde-authentication-agent-1

            xwayland {
                force_zero_scaling = true
            }

            general {
                gaps_in = 5
                gaps_out = 10
                border_size = 2
                col.active_border = rgb(1d2240)
                col.inactive_border = rgba(141414bf)
                resize_on_border = true
                allow_tearing = false
                layout = dwindle
            }

            decoration {
                rounding = 10
                active_opacity = 1.0
                inactive_opacity = 1.0
                drop_shadow = true
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
                blur {
                    enabled = true
                    size = 2
                    passes = 2
                    vibrancy = 0.1696
                }
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
            windowrulev2 = opacity 0.9 0.9,class:^(dev.zed.Zed)$

            windowrulev2 = suppressevent maximize, class:.*
            windowrulev2 = opacity 0.98 0.98, class:^(floorp)$
            windowrulev2 = opacity 0.85 0.85, class:^(YouTube Music)$
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
}
