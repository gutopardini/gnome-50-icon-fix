#!/bin/bash

# GNOME 50 Icon Fixer
# Automated fix for missing symbolic icons in 3rd-party themes

set -e

# Default theme if not provided
THEME_NAME=${1:-"Fluent"}

echo "--- GNOME 50 Icon Fixer ---"
echo "Target Theme: $THEME_NAME"

THEME_DIR="$HOME/.local/share/icons/$THEME_NAME"

# Check if theme exists locally
if [ ! -d "$THEME_DIR" ]; then
    if [ -d "/usr/share/icons/$THEME_NAME" ]; then
        echo "Theme found in /usr/share/icons. Creating local override folder..."
        mkdir -p "$HOME/.local/share/icons"
        cp -r "/usr/share/icons/$THEME_NAME" "$HOME/.local/share/icons/"
        THEME_DIR="$HOME/.local/share/icons/$THEME_NAME"
    else
        echo "Error: Theme '$THEME_NAME' not found."
        echo "Please provide your theme name as an argument: ./fix-icons.sh YourTheme"
        exit 1
    fi
fi

TARGET_DIR="$THEME_DIR/symbolic/categories"
mkdir -p "$TARGET_DIR"

echo "MAPPING: Linking Adwaita symbols to $THEME_NAME..."

declare -A MAPPING=(
    ["category-create-symbolic.svg"]="applications-graphics-symbolic.svg"
    ["category-work-symbolic.svg"]="applications-utilities-symbolic.svg"
    ["category-play-symbolic.svg"]="applications-games-symbolic.svg"
    ["category-socialize-symbolic.svg"]="applications-multimedia-symbolic.svg"
    ["category-learn-symbolic.svg"]="applications-science-symbolic.svg"
    ["category-develop-symbolic.svg"]="applications-engineering-symbolic.svg"
)

ADWAITA_DIR="/usr/share/icons/Adwaita/symbolic/categories"

# Verify Adwaita source exists
if [ ! -d "$ADWAITA_DIR" ]; then
    echo "Error: Adwaita icon directory not found at $ADWAITA_DIR"
    exit 1
fi

for NEW_ICON in "${!MAPPING[@]}"; do
    SRC_ICON="${MAPPING[$NEW_ICON]}"
    if [ -f "$ADWAITA_DIR/$SRC_ICON" ]; then
        cp "$ADWAITA_DIR/$SRC_ICON" "$TARGET_DIR/$NEW_ICON"
        echo "  [OK] $NEW_ICON created."
    else
        echo "  [SKIP] Source $SRC_ICON not found."
    fi
done

echo "Refreshing icon caches (may require sudo for system cache)..."
sudo gtk-update-icon-cache -f /usr/share/icons/hicolor/
gtk-update-icon-cache -f "$THEME_DIR"

echo "--------------------------------------------------"
echo "Success! Please restart GNOME Software or re-log."
