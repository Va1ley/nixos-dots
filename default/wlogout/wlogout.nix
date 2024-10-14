{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "Exit";
        "keybind" = "e";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "lock";
        "action" = "sleep 1; hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono NF", FontAwesome, sans-serif;
      	background-image: none;
      	transition: 20ms;
      }
      window {
      	background-color: rgba(12, 12, 12, 0.1);
      }
      button {
        font-size:20px;
        background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      	border-style: solid;
      	background-color: rgba(12, 12, 12, 0.55);
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }
      button:focus,
      button:active,
      button:hover {
        background-color: rgba(12, 12, 12, 0.75);
      }
      #logout {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("/home/emers/.config/home-manager/default/wlogout/logout.png"));
      }
      #suspend {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("/home/emers/.config/home-manager/default/wlogout/suspend.png"));
      }
      #shutdown {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("/home/emers/.config/home-manager/default/wlogout/shutdown.png"));
      }
      #reboot {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("/home/emers/.config/home-manager/default/wlogout/reboot.png"));
      }
      #lock {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("/home/emers/.config/home-manager/default/wlogout/lock.png"));
      }
      #hibernate {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("/home/emers/.config/home-manager/default/wlogout/hibernate.png"));
      }
    '';
  };
}
