{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  # To help brwap (steam wrapper) think its feeling okay
  security.wrappers.bwrap = {
    owner = "root";
    group = "root";
    source = "${pkgs.bubblewrap}/bin/bwrap";
    setuid = true;
  };

  services.gnome.gnome-keyring.enable = true; # Provides default keyring

  # Greeter
  services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "hyprland";

      configHome = "/home/emers";
      logs = {
          save = true;
          path = "/tmp/dms-greeter.log";
      };
  };

  # Nvidia Replay-ish
  programs.gpu-screen-recorder.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
    environment.systemPackages = with pkgs; [
        # Essentials
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        pavucontrol
        wget
        hyprshot
        home-manager
        file-roller
        egl-wayland
        loupe
        linuxKernel.packages.linux_zen.xone
        uwsm
        # Nemo
        nemo-with-extensions
        nemo-emblems
        # nemo-python
        nemo-fileroller
        nemo-preview
        nemo-seahorse
        # Utilities
        wineWow64Packages.stable
        gpu-screen-recorder
        btop
        kitty
        fastfetch
        oh-my-posh
        git
        nixd
        mpv
        pamixer
        playerctl
        wireguard-tools
        nil
        pywalfox-native
        qt6Packages.qt6ct
        nodejs
        gemini-cli
        # Apps
        floorp-bin
        zed-editor
        github-desktop
        # bitwarden-desktop
        vesktop
        spicetify-cli
        spotify
        gnome-calculator
        glib-networking
        obsidian
        (prismlauncher.override {
            jdks = [
                openjdk25
                openjdk21
                jre8
                graalvmPackages.graalvm-oracle_17
            ];
            additionalLibs = [
              libxkbcommon
              libxkbfile
              libx11
              libxcb
              libxinerama
              libxt
              libxtst
              libxau
              libxdmcp
              libxext
              libsm
              libice
              libbsd
              libuuid
              libdecor
            ];
        })
        papers
        ardour
        cyanrip
        appimage-run
        obs-studio
        waywall
        openjdk25
        ungoogled-chromium
        glfw3-minecraft
        pear-desktop
        mangohud
    ];

  # Allow dynamically linxed execulatables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
      # Add missing dynamic libraries for unpackaged programs here
  ];

  # Enables TLS support for gnomes packages
  services.gnome.glib-networking.enable = true;
  services.flatpak.enable = true;
    programs.dsearch = {
        enable = true;
        systemd.enable = true;
    };

    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    xdg.portal.enable = true;
}
