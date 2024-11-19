{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./hardware.nix
      inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify =
     let
       spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
     in
     {
       enable = true;
       enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplayMod
        autoSkipVideo
        shuffle
        fullAlbumDate
        wikify
        songStats
        history
        hidePodcasts
        adblock
        fullScreen
        beautifulLyrics
       ];
       theme = spicePkgs.themes.catppuccin;
       colorScheme = "mocha";
     };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Make steam work
  programs.steam = {
    enable = true;
    package = with pkgs; steam.override {
        extraPkgs = pkgs: [ attr ];
    };
  };

  services.gnome.gnome-keyring.enable = true;

  # WM
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # Screensharing
  services.dbus.enable = true;
	xdg.portal = {
  	enable = true;
  	wlr.enable = true;
  	extraPortals = [
    		pkgs.xdg-desktop-portal-gtk
  	];
  };
  # Hint Electron apps to use wayland
  environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
  };
  # SDDM
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    enableHidpi = true;
    wayland.enable = true;
  };

  # Catppuccin
  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "mocha";
  };
  services.displayManager.sddm.catppuccin.fontSize = "14";

  # Webdev Stuff
  services.nginx = {
    enable = true;
    virtualHosts = {
        "bento-app.uk" = {
            forceSSL = true;
            sslCertificate = "/var/www/certs/selfsigned.crt";
            sslCertificateKey = "/var/www/certs/selfsigned.key";
            root = "/var/www/bento-app.uk";
            locations."~ \\.php$".extraConfig = ''
              fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
              fastcgi_index index.php;
            '';
        };
    };
  };
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  services.phpfpm.pools.mypool = {
    user = "nobody";
    settings = {
      "pm" = "dynamic";
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };

  users.users.emers = {
     isNormalUser = true;
     extraGroups = [
           	"wheel"
           	"networkmanager"
           	"video"
     ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
	# Essentials
  	xdg-desktop-portal-gtk
  	xdg-desktop-portal-hyprland
	ulauncher
	waybar
	wlogout
	pavucontrol
	wget
	swaybg
	networkmanagerapplet
	swaynotificationcenter
	hyprshot
	hypridle
	home-manager
    file-roller
	hyprlock
	catppuccin-sddm
	fprintd
	loupe
	# Utilities
	wineWowPackages.stable
	btop
	kitty
	fastfetch
	oh-my-posh
	git
	nixd
	mpv
	pamixer
	playerctl
	nodejs
	wireguard-tools
	rustup
	# Apps
	firefox
	floorp
	zed-editor
	github-desktop
	bitwarden
	vesktop
	spicetify-cli
	spotify
	spotify-tray
	gnome-calculator
	obsidian
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
  fonts.packages = with pkgs; [
	nerdfonts
	jetbrains-mono
	emojione
	noto-fonts-cjk-sans
	takao
    kochi-substitute
    roboto
  ];

  # Thunar stuff
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, etc
  services.udisks2.enable = true; # Automatic mounting
  services.tumbler.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-media-tags-plugin
    thunar-archive-plugin
    thunar-volman
  ];

  virtualisation.vmware.host.enable = true;

  # Allow dynamically linxed execulatables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add missing dynamic libraries for unpackaged programs here
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "24.05"; # DO NOT CHANGE THIS EVER FR
}
