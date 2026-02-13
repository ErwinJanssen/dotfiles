#!/bin/sh
set -eu

# vibe-sandboxed - Run mistral-vibe in a Podman container
#
# This script creates and runs a containerized environment for mistral-vibe to
# ensure isolation from the host system while maintaining access to the current
# working directory and vibe configuration.
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
# --volume: Mount current directory as /workdir and vibe config directory
# --workdir: Set working directory inside container to /workdir
podman run --rm --interactive --tty \
    --volume "$(pwd):/workdir:rw,z" \
    --volume "$VIBE_DIR:/root/.vibe:rw,z" \
    --workdir /workdir \
    "$CONTAINER_NAME" vibe "$@"
