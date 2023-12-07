# Add Flatpak bin directory to PATH
fish_add_path --path /var/lib/flatpak/exports/bin

# Add local bin directory to PATH
fish_add_path --global "$HOME/.local/bin"
