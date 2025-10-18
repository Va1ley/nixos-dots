#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Repository URL
REPO_URL="https://github.com/Va1ley/nixos-dots.git"
TEMP_DIR="/tmp/nixos-dots-deploy"

# Cleanup function
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        print_info "Cleaning up temporary files..."
        rm -rf "$TEMP_DIR"
    fi
}

trap cleanup EXIT

# Main deployment script
main() {
    print_info "Starting NixOS configuration deployment..."

    # Clone the repository
    print_info "Cloning repository from $REPO_URL..."
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
    
    
    if ! git clone "$REPO_URL" "$TEMP_DIR"; then
        print_error "Failed to clone repository"
        exit 1
    fi

    # Ask user about device type
    echo ""
    print_info "What type of device are you setting up?"
    echo "1) Desktop"
    echo "2) Laptop"
    read -r -p "Enter your choice (1 or 2): " device_choice

    case $device_choice in
        1)
            print_info "Configuring for Desktop..."
            DEVICE_TYPE="desktop"
            ;;
        2)
            print_info "Configuring for Laptop..."
            DEVICE_TYPE="laptop"
            ;;
        *)
            print_error "Invalid choice. Exiting."
            exit 1
            ;;
    esac

    # Modify configuration files if laptop is selected
    if [ "$DEVICE_TYPE" = "laptop" ]; then
        print_info "Modifying configuration files for laptop..."
        
        # Modify home.nix
        HOME_NIX="$TEMP_DIR/home-manager/home.nix"
        if [ -f "$HOME_NIX" ]; then
            # Uncomment laptop hyprland line and comment desktop hyprland line
            sed -i 's|^\s*\./desktop/hyprland\.nix|    # ./desktop/hyprland.nix|' "$HOME_NIX"
            sed -i 's|^\s*#\s*\./laptop/hyprland\.nix|    ./laptop/hyprland.nix|' "$HOME_NIX"
            print_info "Modified home.nix for laptop configuration"
        else
            print_error "home.nix not found"
            exit 1
        fi

        # Modify configuration.nix
        CONFIG_NIX="$TEMP_DIR/nixos/configuration.nix"
        if [ -f "$CONFIG_NIX" ]; then
            # Comment desktop lines
            sed -i 's|^\(\s*\)\./desktop/device\.nix|\1# ./desktop/device.nix|' "$CONFIG_NIX"
            sed -i 's|^\(\s*\)\./desktop/hardware-configuration\.nix|\1# ./desktop/hardware-configuration.nix|' "$CONFIG_NIX"
            # Uncomment laptop lines
            sed -i 's|^\(\s*\)#\s*\./laptop/device\.nix|\1./laptop/device.nix|' "$CONFIG_NIX"
            sed -i 's|^\(\s*\)#\s*\./laptop/hardware-configuration\.nix|\1./laptop/hardware-configuration.nix|' "$CONFIG_NIX"
            print_info "Modified configuration.nix for laptop configuration"
        else
            print_error "configuration.nix not found"
            exit 1
        fi
    else
        print_info "Using default desktop configuration (no changes needed)"
    fi

    # Create target directories if they don't exist
    print_info "Creating target directories..."
    mkdir -p ~/nix-configs/
    mkdir -p ~/.config/home-manager/

    # Copy nixos folder contents to ~/nix-configs/
    print_info "Copying nixos configuration to ~/nix-configs/..."
    if ! cp -r "$TEMP_DIR/nixos/"* ~/nix-configs/; then
        print_error "Failed to copy nixos configuration"
        exit 1
    fi

    # Copy home-manager folder contents to ~/.config/home-manager/
    print_info "Copying home-manager configuration to ~/.config/home-manager/..."
    if ! cp -r "$TEMP_DIR/home-manager/"* ~/.config/home-manager/; then
        print_error "Failed to copy home-manager configuration"
        exit 1
    fi

    # Run setup commands
    print_info "Running NixOS setup commands..."
    echo ""
    
    print_info "Step 1: Updating nix channels and flake..."
    if ! sudo nix-channel --update && nix flake update --flake /home/emers/nix-configs/ && nixbackup; then
        print_warning "First setup command failed, continuing anyway..."
    fi

    echo ""
    print_info "Step 2: Switching home-manager configuration..."
    if ! home-manager switch --flake ~/.config/home-manager#emers@host --impure; then
        print_warning "Home-manager switch failed, continuing anyway..."
    fi

    echo ""
    print_info "Step 3: Final update of nix channels and flake..."
    if ! sudo nix-channel --update && nix flake update --flake /home/emers/nix-configs/ && nixbackup; then
        print_warning "Final setup command failed, continuing anyway..."
    fi

    echo ""
    print_info "Deployment complete!"
    print_info "Your NixOS configuration has been deployed successfully."
}

# Run main function
main
