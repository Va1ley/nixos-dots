{
    programs.hyprlock = {
        enable = true;
        extraConfig = ''
            background {
                path = screenshot
                blur_passes = 3
                brightness = 0.6
            }

            input-field {
               	size = 400, 50
               	outline_thickness = 1
               	rounding = 10
               	outer_color = rgb(585b70)
               	inner_color = rgb(181825)
               	font_color = rgb(cdd6f4)
               	check_color = rgb(a6e3a1)
               	fail_color = rgb(f38ba8)
               	fade_on_empty = false
                placeholder_text = パスワードを入力してください
            }

            label {
                text = cmd[update:1000]date +"%I:%M:%S %p"
                color = rgb(b4befe)
                font_size = 45
                font_family = JetBrains Mono Nerd Font Mono Semibold

                position = 0, 60
                halign = center
                valign = center
            }

            label {
                text = Master of the digital dark arts, most cultured individual, and 電波 enjoyer
                color = rgb(b4befe)
                font_size = 18
                font_family = JetBrains Mono Nerd Font Mono

                position = 0, -450
                halign = center
                valign = center
            }
        '';
    };
}
