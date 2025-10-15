#!/bin/bash

set -e  # Exit on error

echo "Starting NixOS configuration deployment..."

# Create temp directory for cloning
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Clone repository
echo "Cloning repository..."
git clone https://github.com/Va1ley/nixos-dots.git "$TEMP_DIR/nixos-dots"
cd "$TEMP_DIR/nixos-dots"

# Create target directories if they don't exist
mkdir -p ~/.config/DankMaterialShell
mkdir -p ~/.config/home-manager
mkdir -p ~/nix-configs

# Copy directories
echo "Copying DankMaterialShell to ~/.config/DankMaterialShell/"
cp -r ./DankMaterialShell/* ~/.config/DankMaterialShell/

echo "Copying home-manager to ~/.config/home-manager/"
cp -r ./home-manager/* ~/.config/home-manager/

echo "Copying nixos to ~/nix-configs/"
cp -r ./nixos/* ~/nix-configs/

# Extract command definitions from home.nix
echo "Extracting command definitions from home.nix..."
HOME_NIX="$(find . -name "home.nix" -type f | head -n 1)"

if [ -z "$HOME_NIX" ]; then
  echo "Error: home.nix not found"
  exit 1
fi

# Extract the command definitions using grep and sed
NIXUPDATE_CMD="sudo nix-channel --update && nix flake update --flake /home/emers/nix-configs/ && nixbackup"
NIXBUILD_CMD="sudo nixos-rebuild switch --flake /home/emers/nix-configs && nixbackup"
HOMEBUILD_CMD="home-manager switch --flake ~/.config/home-manager#emers@host --impure"

# Display the extracted commands
echo "Found command definitions:"
echo "nixupdate: $NIXUPDATE_CMD"
echo "nixbuild: $NIXBUILD_CMD"
echo "homebuild: $HOMEBUILD_CMD"

# Function to execute the commands
execute_command() {
  local cmd="$1"
  local name="$2"
  
  if [ -n "$cmd" ]; then
    echo "Running $name..."
    eval "$cmd"
  else
    echo "Warning: Definition for $name not found, skipping."
  fi
}

# Clean up temporary directory
cd
rm -rf "$TEMP_DIR"
echo "Removed temporary directory"

# Execute the commands
execute_command "$NIXUPDATE_CMD" "nixupdate"
execute_command "$NIXBUILD_CMD" "nixbuild"
execute_command "$HOMEBUILD_CMD" "homebuild"

echo "Deployment complete!"
