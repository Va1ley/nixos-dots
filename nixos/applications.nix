{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  services.gnome.gnome-keyring.enable = true; # Provides default keyring

  # Greeter
  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/emers";
  };

  # Nvidia Replay-ish
  programs.gpu-screen-recorder.enable = true;

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
        # Nemo
        nemo-with-extensions
        nemo-emblems
        nemo-python
        nemo-fileroller
        nemo-preview
        nemo-seahorse
        # Utilities
        wineWowPackages.stable
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
        bitwarden-desktop
        vesktop
        spicetify-cli
        spotify
        gnome-calculator
        glib-networking
        obsidian
        (prismlauncher.override {
            jdks = [
                openjdk25
            ];
        })
        papers
        reaper
        cyanrip
        nicotine-plus
    ];

  # Allow dynamically linxed execulatables
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #     # Add missing dynamic libraries for unpackaged programs here
  # ];


  services.flatpak.enable = true;

  # Enables TLS support for gnomes packages
  services.gnome.glib-networking.enable = true;

  programs.dsearch = {
      enable = true;
      systemd.enable = true;
  };
}
