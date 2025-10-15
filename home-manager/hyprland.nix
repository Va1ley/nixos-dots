{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = ___GLX_VENDOR_LIBRARY_NAME,nvidia

      monitor = DP-6, 1920x1080@144, 0x0, 1
      monitor = DP-4, 1920x1080@60, auto-left, 1
      monitor = HDMI-A-2, 1920x1080@60, auto-down, 1

      workspace = name:2, monitor:DP-4
      exec-once = hyprctl dispatch workspace 2
      workspace = name:3, monitor:HDMI-A-2
      exec-once = hyprctl dispatch workspace 3
      exec-once = [worspace 3 silent] vesktop
      workspace = name:1, monitor:DP-6
      exec-once = hyprctl dispatch workspace 1

      $terminal = kitty
      $fileManager = nemo
      $menu = ulauncher-toggle

      exec-once = fcitx & hypridle & gnome-keyring-daemon

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
          touchpad {
              natural_scroll = false
          }
          sensitivity = -0.8
      }

      $mainMod = SUPER

      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod, C, killactive,
      # bind = $mainMod, M, exec, wlogout --protocol layer-shell
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = ALT, SPACE, exec, $menu
      bind = $mainMod, P, pseudo,
      bind = $mainMod, J, togglesplit,
      bind = $mainMod, F, exec, floorp
      bind = $mainMod SHIFT, S, exec, hyprshot -m region -o ~/Pictures
      # bind = $mainMod, L, exec, hyprlock
      bind = $mainMod, O, fullscreen, 0
      bind = SUPER, P, exec, pkill -SIGUSR1 waybar
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
      bind = $mainMod SHIFT, B, movetoworkspace, special:magic
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

      # DMS
      # Required for clipboard history integration
      exec-once = bash -c "wl-paste --watch cliphist store &"

      # Recommended (must install polkit-mate beforehand) for elevation prompts
      # exec-once = /usr/lib/mate-polkit/polkit-mate-authentication-agent-1
      # This may be a different path on different distributions, the above is for the arch linux mate-polkit package

      # Starts DankShell
      exec-once = dms run

      # Dank keybinds
      # 1. These should not be in conflict with any pre-existing keybindings
      # 2. You need to merge them with your existing config if you want to use these
      # 3. You can change the keys to whatever you want, if you prefer something different
      # 4. For the increment/decrement ones you can change the steps to whatever you like too

      # Application and system controls
      bind = SUPER, Space, exec, dms ipc call spotlight toggle
      # bind = SUPER, V, exec, dms ipc call clipboard toggle
      # bind = SUPER, M, exec, dms ipc call processlist toggle
      bind = SUPER, N, exec, dms ipc call notifications toggle
      bind = SUPER, comma, exec, dms ipc call settings toggle
      # bind = SUPER, P, exec, dms ipc call notepad toggle
      bind = SUPER, L, exec, dms ipc call lock lock
      bind = SUPER, M, exec, dms ipc call powermenu toggle
      bind = SUPER, T, exec, dms ipc call control-center toggle

      # Audio controls (function keys)
      # bindl = , XF86AudioRaiseVolume, exec, dms ipc call audio increment 3
      # bindl = , XF86AudioLowerVolume, exec, dms ipc call audio decrement 3
      # bindl = , XF86AudioMute, exec, dms ipc call audio mute
      # bindl = , XF86AudioMicMute, exec, dms ipc call audio micmute

      # Brightness controls (function keys)
      bindl = , XF86MonBrightnessUp, exec, dms ipc call brightness increment 5 ""
      # You can override the default device for e.g. keyboards by adding the device name to the last param
      bindl = , XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5 ""

      # Night mode toggle
      bind = SUPERSHIFT, N, exec, dms ipc call night toggle
    '';
  };
}
