# Set and export the Guix profile path, as recommended by Guix itself.
set --global --export GUIX_PROFILE "$HOME/.config/guix/current"

# Set the path to the locales installed by Guix (`guix install glibc-locales`)
set --global --export GUIX_LOCPATH "$HOME/.guix-profile/lib/locale"

# Add the bin directory of the current Guix profile to `$PATH`.
fish_add_path --global "$GUIX_PROFILE/bin"
