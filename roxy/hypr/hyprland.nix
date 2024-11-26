{
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = ''
            source=~/.config/home-manager/default/hypr/mocha.conf
            exec-once = swaybg -i ~/.config/home-manager/roxy/hypr/wallpaper.jpg -m fill & waybar & swaync

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
        '';
    };
}
