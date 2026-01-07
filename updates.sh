#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

# Updates the theme for bat
update_bat_theme() {
    local destdir="home/.config/bat/themes"
    local theme="Macchiato.tmTheme"
    curl -sS -L -o "$destdir/Catppuccin $theme" "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20$theme"
    echo "bat theme updated"
}

# Update try (https://github.com/tobi/try)
update_try() {
    curl -sL https://raw.githubusercontent.com/tobi/try/refs/heads/main/try.rb > home/.localrb/try.rb
    git add --chmod=+x home/.localrb/try.rb
    echo "try has been updated"
}

if [ -z "$(git status --porcelain)" ]; then 
    # Working directory clean
    update_bat_theme
    update_try
    git status
else 
    # Uncommitted changes
    echo "ERROR: working directory is not clean"
    git status
    exit 1
fi
