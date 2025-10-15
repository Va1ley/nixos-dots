{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  services.gnome.gnome-keyring.enable = true; # Provides default keyring

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  # Greeter
  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/emers";
  };

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
    # Nemo
    nemo-with-extensions
    nemo-emblems
    nemo-python
    nemo-fileroller
    nemo-preview
    nemo-seahorse
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
    wireguard-tools
    nil
    pywalfox-native
    # Apps
    floorp-bin
    zed-editor
    github-desktop
    bitwarden
    vesktop
    spicetify-cli
    spotify
    gnome-calculator
    obsidian
  ];

  # # Allow dynamically linxed execulatables
  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #     # Add missing dynamic libraries for unpackaged programs here
  # ];
}
