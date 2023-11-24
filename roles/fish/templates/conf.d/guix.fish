# Set and export the Guix profile path, as recommended by Guix itself.
set --global --export GUIX_PROFILE "$HOME/.config/guix/current"

# Set the path to the locales installed by Guix (`guix install glibc-locales`)
set --global --export GUIX_LOCPATH "$HOME/.guix-profile/lib/locale"

# Adding the bin directory of the current Guix profile to `$PATH` is not done
# here, but in the main `config.fish`. This is done to ensure that this
# directory is the first element of `$PATH`.
