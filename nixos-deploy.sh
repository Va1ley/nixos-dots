#!/usr/bin/env bash

# NixOS Configuration Deployment Script
# This script deploys the NixOS configuration from this repository to a new machine

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored messages
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    error "Please do not run this script as root. It will use sudo when needed."
fi

# Check if running on NixOS
if [ ! -f /etc/NIXOS ]; then
    error "This script must be run on NixOS."
fi

# Check if git is available
if ! command -v git &> /dev/null; then
    error "git is not installed. Please install it first."
fi

# Get the script directory (repository root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NIXOS_DIR="$SCRIPT_DIR/nixos"
HOME_MANAGER_DIR="$SCRIPT_DIR/home-manager"

info "NixOS Deployment Script"
info "Repository location: $SCRIPT_DIR"
echo ""

# Check if nixos and home-manager directories exist
if [ ! -d "$NIXOS_DIR" ]; then
    error "NixOS configuration directory not found at $NIXOS_DIR"
fi

if [ ! -d "$HOME_MANAGER_DIR" ]; then
    warn "Home Manager configuration directory not found at $HOME_MANAGER_DIR"
fi

# Prompt for device type
echo "Please select your device type:"
echo "  1) Desktop (with NVIDIA GPU)"
echo "  2) Laptop (with fingerprint reader and backlight)"
echo ""
read -r -p "Enter your choice (1 or 2): " device_choice

case $device_choice in
    1)
        DEVICE_TYPE="desktop"
        info "Selected: Desktop configuration"
        ;;
    2)
        DEVICE_TYPE="laptop"
        info "Selected: Laptop configuration"
        ;;
    *)
        error "Invalid choice. Please run the script again and select 1 or 2."
        ;;
esac
echo ""

# Prompt for username (default: emers)
read -r -p "Enter username (default: emers): " username
username=${username:-emers}
info "Using username: $username"
echo ""

# Prompt for hostname
read -r -p "Enter hostname (default: device): " hostname
hostname=${hostname:-device}
info "Using hostname: $hostname"
echo ""

# Determine target configuration directory
TARGET_DIR="/home/$username/nix-configs"

# Ask if user wants to use a different location
read -r -p "Configuration will be copied to $TARGET_DIR. Change location? (y/N): " change_location
if [[ "$change_location" =~ ^[Yy]$ ]]; then
    read -r -p "Enter new location: " custom_target
    TARGET_DIR="${custom_target/#\~/$HOME}"
fi
info "Target directory: $TARGET_DIR"
echo ""

# Create target directory
info "Creating target directory..."
mkdir -p "$TARGET_DIR"

# Copy NixOS configuration
info "Copying NixOS configuration to $TARGET_DIR..."
cp -r "$NIXOS_DIR"/* "$TARGET_DIR/"
success "NixOS configuration copied"

# Generate hardware-configuration.nix if it doesn't exist
HARDWARE_CONFIG="$TARGET_DIR/$DEVICE_TYPE/hardware-configuration.nix"
if [ ! -f "$HARDWARE_CONFIG" ]; then
    warn "Hardware configuration not found for $DEVICE_TYPE"
    read -r -p "Generate hardware-configuration.nix now? (Y/n): " gen_hw
    if [[ ! "$gen_hw" =~ ^[Nn]$ ]]; then
        info "Generating hardware configuration..."
        sudo nixos-generate-config --show-hardware-config | tee "$HARDWARE_CONFIG" > /dev/null
        success "Hardware configuration generated at $HARDWARE_CONFIG"
    else
        warn "Skipping hardware configuration generation. You'll need to create it manually."
    fi
fi

# Update configuration.nix to use the correct device
info "Updating configuration.nix for $DEVICE_TYPE..."
CONFIG_FILE="$TARGET_DIR/configuration.nix"

# Create a backup
cp "$CONFIG_FILE" "$CONFIG_FILE.backup"

# Update the imports section
if [ "$DEVICE_TYPE" = "desktop" ]; then
    sed -i "s|# ./desktop/device.nix|./desktop/device.nix|g" "$CONFIG_FILE"
    sed -i "s|# ./desktop/hardware-configuration.nix|./desktop/hardware-configuration.nix|g" "$CONFIG_FILE"
    sed -i "s|./laptop/device.nix|# ./laptop/device.nix|g" "$CONFIG_FILE"
    sed -i "s|./laptop/hardware-configuration.nix|# ./laptop/hardware-configuration.nix|g" "$CONFIG_FILE"
else
    sed -i "s|./desktop/device.nix|# ./desktop/device.nix|g" "$CONFIG_FILE"
    sed -i "s|./desktop/hardware-configuration.nix|# ./desktop/hardware-configuration.nix|g" "$CONFIG_FILE"
    sed -i "s|# ./laptop/device.nix|./laptop/device.nix|g" "$CONFIG_FILE"
    sed -i "s|# ./laptop/hardware-configuration.nix|./laptop/hardware-configuration.nix|g" "$CONFIG_FILE"
fi

# Update username if not 'emers'
if [ "$username" != "emers" ]; then
    sed -i "s|users.users.emers|users.users.$username|g" "$CONFIG_FILE"
fi

success "Configuration updated for $DEVICE_TYPE"

# Update flake.nix hostname if needed
if [ "$hostname" != "device" ]; then
    info "Updating hostname in flake.nix..."
    FLAKE_FILE="$TARGET_DIR/flake.nix"
    sed -i "s|device = nixpkgs.lib.nixosSystem|$hostname = nixpkgs.lib.nixosSystem|g" "$FLAKE_FILE"
    success "Hostname updated to $hostname"
fi

# Update flake inputs
info "Updating flake inputs..."
cd "$TARGET_DIR"
nix flake update
success "Flake inputs updated"

# Build and deploy NixOS configuration
echo ""
info "Ready to deploy NixOS configuration"
read -r -p "Deploy NixOS configuration now? (Y/n): " deploy_nixos
if [[ ! "$deploy_nixos" =~ ^[Nn]$ ]]; then
    info "Building and deploying NixOS configuration..."
    sudo nixos-rebuild switch --flake "$TARGET_DIR#$hostname"
    success "NixOS configuration deployed successfully!"
else
    warn "Skipping NixOS deployment. Run manually with:"
    warn "  sudo nixos-rebuild switch --flake $TARGET_DIR#$hostname"
fi

# Handle Home Manager configuration
echo ""
if [ -d "$HOME_MANAGER_DIR" ]; then
    info "Home Manager configuration found"
    read -r -p "Deploy Home Manager configuration? (y/N): " deploy_home
    if [[ "$deploy_home" =~ ^[Yy]$ ]]; then
        HM_TARGET="/home/$username/.config/home-manager"
        info "Copying Home Manager configuration to $HM_TARGET..."
        mkdir -p "$HM_TARGET"
        cp -r "$HOME_MANAGER_DIR"/* "$HM_TARGET/"
        
        # Update home-manager configuration
        HM_CONFIG="$HM_TARGET/home.nix"
        if [ "$username" != "emers" ]; then
            sed -i "s|username = \"emers\"|username = \"$username\"|g" "$HM_CONFIG"
            sed -i "s|homeDirectory = \"/home/emers\"|homeDirectory = \"/home/$username\"|g" "$HM_CONFIG"
        fi
        
        # Update home-manager flake
        HM_FLAKE="$HM_TARGET/flake.nix"
        if [ "$username" != "emers" ] || [ "$hostname" != "host" ]; then
            sed -i "s|\"emers@host\"|\"$username@$hostname\"|g" "$HM_FLAKE"
        fi
        
        # Update device type in home.nix
        if [ "$DEVICE_TYPE" = "desktop" ]; then
            sed -i "s|# ./desktop/hyprland.nix|./desktop/hyprland.nix|g" "$HM_CONFIG"
            sed -i "s|./laptop/hyprland.nix|# ./laptop/hyprland.nix|g" "$HM_CONFIG"
        else
            sed -i "s|./desktop/hyprland.nix|# ./desktop/hyprland.nix|g" "$HM_CONFIG"
            sed -i "s|# ./laptop/hyprland.nix|./laptop/hyprland.nix|g" "$HM_CONFIG"
        fi
        
        success "Home Manager configuration copied"
        
        # Update flake inputs
        info "Updating Home Manager flake inputs..."
        cd "$HM_TARGET"
        nix flake update
        
        info "Deploying Home Manager configuration..."
        home-manager switch --flake "$HM_TARGET#$username@$hostname" --impure
        success "Home Manager configuration deployed successfully!"
    fi
fi

echo ""
success "Deployment complete!"
echo ""
info "Summary:"
info "  - NixOS configuration: $TARGET_DIR"
info "  - Device type: $DEVICE_TYPE"
info "  - Username: $username"
info "  - Hostname: $hostname"
echo ""
info "Useful commands:"
info "  - Rebuild NixOS: sudo nixos-rebuild switch --flake $TARGET_DIR#$hostname"
if [ -d "$HOME_MANAGER_DIR" ]; then
    info "  - Rebuild Home Manager: home-manager switch --flake ~/.config/home-manager#$username@$hostname --impure"
fi
info "  - Update flake inputs: nix flake update --flake $TARGET_DIR"
info "  - Collect garbage: sudo nix-collect-garbage -d"
echo ""
info "You may need to reboot for all changes to take effect."
