# Add Flatpak bin directory to PATH
fish_add_path --path /var/lib/flatpak/exports/bin

# Add local bin directory to PATH
fish_add_path --global "$HOME/.local/bin"

# Add directory for Rust binaries to PATH
fish_add_path --global "$HOME/.cargo/bin"

# Add directory for Nix profile
fish_add_path --global "$HOME/.nix-profile/bin"
