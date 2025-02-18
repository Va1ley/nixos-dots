
{
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = ''
            exec-once = swaybg -i ~/.config/home-manager/holo/hypr/holo.jpg & waybar

            general {
                gaps_in = 5
                gaps_out = 10
                border_size = 2
                col.active_border = rgb(b88e5f) rgb(b88e5f) 45deg
                col.inactive_border = rgba(595959aa)
                resize_on_border = true
                allow_tearing = false
                layout = dwindle
            }
        '';
    };
}
