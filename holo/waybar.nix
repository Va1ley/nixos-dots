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
                background: #32281c;
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
                background: #32281c;
                color: #cdd6f4;
                padding: 5px 10px;
            }

            .module {
                margin-top: 6px;
                background: #32281c;
                color: #d4c5b2;
                padding: 5px 10px;
            }
            .modules-left .module {
                margin-right: 10px;
            }
            .modules-right .module {
                margin-left: 10px;
            }

            #workspaces button.active {
                color: #ffffff;
            }

            #pulseaudio-slider,
            #backlight-slider {
                margin-left: 0px;
                border-top-left-radius: 0px;
                border-bottom-left-radius: 0px;
                min-width: 80px;
            }

            #backlight,
            #pulseaudio {
                border-top-right-radius: 0px;
                border-bottom-right-radius: 0px;
            }
        '';
    };
}
