{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      general {
          gaps_in = 5
          gaps_out = 10
          border_size = 0
          # col.active_border = $blue $lavender 45deg
          # col.inactive_border = rgba(595959aa)
          resize_on_border = true
          allow_tearing = false
          layout = dwindle
      }
    '';
  };
}
