{
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
                    format-wifi = "   {essid}";
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
                    format = "{icon}   {capacity}%";
                    format-charging = "   {capacity}%";
                    format-plugged = "   {capacity}%";
                    format-alt = "{time}   {icon}";
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
                    format = "{icon}   {volume}%";
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
}
