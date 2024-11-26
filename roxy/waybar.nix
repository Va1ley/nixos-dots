{
    programs.waybar = {
        enable = true;
        style = ''
            * {
                padding: 0px 5px;
                font-family: "JetbrainsMono Nerd Font";
                font-size: 16px;
                min-height: 12px;
                border-radius: 10px;
            }

            #window {
                background: #1d2240;
                margin-top: 6px;
                padding: 5px;
            }
            window#waybar {
                background: transparent;
            }
            window#waybar.empty #window {
                background-color: transparent;
            }

            tooltip {
                background: #1d2240;
                color: #cdd6f4;
                padding: 5px 10px;
            }

            .module {
                margin-top: 6px;
                background: #1d2240;
                color: #cdd6f4;
                padding: 5px 10px;
            }
            .modules-left .module {
                margin-right: 10px;
            }
            .modules-right .module {
                margin-left: 10px;
            }

            #workspaces button.active {
                color: #7581c1;
            }

            #pulseaudio-slider,
            #backlight-slider {
                margin-left: 0px;
                border-top-left-radius: 0px;
                border-bottom-left-radius: 0px;
                min-width: 80px;
            }

            #pulseaudio-slider highlight {
                min-width: 10px;
                border-radius: 5px;
                background-color: green;
            }

            #backlight,
            #pulseaudio {
                border-top-right-radius: 0px;
                border-bottom-right-radius: 0px;
            }
        '';
    };
}
