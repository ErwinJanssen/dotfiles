#!/bin/sh
set -eu

# vibe-sandboxed - Run mistral-vibe in a Podman container
#
# This script creates and runs a containerized environment for mistral-vibe to
# ensure isolation from the host system while maintaining access to:
# - Current working directory (read-write)
# - Vibe configuration directory (read-write)
# - Nix profile with binaries in PATH (read-only)
# - Nix store for resolving profile symlinks (read-only)
#
# Usage: vibe-sandboxed [vibe_args...]
# Examples:
#   vibe-sandboxed --help                  # Show mistral-vibe help
#   vibe-sandboxed --version               # Show mistral-vibe version
#   vibe-sandboxed some_command            # Run specific vibe command
#   vibe-sandboxed --agent=auto-approve    # Run with auto-approve agent

# Configuration variables
CONTAINER_NAME="mistral-vibe-sandbox"     # Name for the Podman container
VIBE_DIR="$HOME/.vibe"                    # Directory for vibe configuration and cache
PYTHON_VERSION="3.13"                     # Python version to use in container

# Build the container image with mistral-vibe installed.
#
# Uses a Dockerfile via stdin to create a lightweight Python environment with
# mistral-vibe version 2.x installed via pip.
podman build --tag "$CONTAINER_NAME" - <<EOF
FROM python:$PYTHON_VERSION
WORKDIR /workdir
RUN pip install --upgrade pip && pip install "mistral-vibe>=2.0.0,<3.0.0"
EOF

# Run mistral-vibe in the container with proper directory mounts
# --rm: Remove container after execution (cleanup)
# --interactive --tty: Keep STDIN open and allocate pseudo-TTY for interactive use
# --volume: Mount current directory, vibe config, nix profile, and nix store
# Note: Using :ro without relabeling for nix store to preserve SELinux context
# --workdir: Set working directory inside container to /workdir
# --env: Set PATH to include nix profile binaries
podman run --rm --interactive --tty \
    --volume "$(pwd):/workdir:rw,z" \
    --volume "$VIBE_DIR:/root/.vibe:rw,z" \
    --volume "$HOME/.nix-profile:/root/.nix-profile:ro,z" \
    --volume "/nix/store:/nix/store:ro" \
    --env PATH="/root/.nix-profile/bin:$PATH" \
    --workdir /workdir \
    "$CONTAINER_NAME" vibe "$@"
