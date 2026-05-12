# Add local bin directory to PATH
fish_add_path --global "$HOME/.local/bin"

# Add directory for Rust binaries to PATH
fish_add_path --global "$HOME/.cargo/bin"

# Add directory for Nix profile
fish_add_path --global "$HOME/.nix-profile/bin"

set --global --export SHELL (which fish)
>>>>>>> c70f380 (fish: use long-form options for set command)
=======
# Set SHELL to the Fish binary path since Fish is always started from Bash
# and $SHELL would otherwise inherit /bin/bash
set --global --export SHELL (which fish)
=======
set --global --export SHELL (which fish)
>>>>>>> c70f380 (fish: use long-form options for set command)
