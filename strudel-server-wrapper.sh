#!/usr/bin/env bash
# Wrapper script for nvim-strudel server on NixOS
# Sets up library paths for native dependencies

# Find ALSA library in nix store
ALSA_LIB=$(find /nix/store -name "libasound.so.2" 2>/dev/null | head -1)
if [ -n "$ALSA_LIB" ]; then
    ALSA_DIR=$(dirname "$ALSA_LIB")
    export LD_LIBRARY_PATH="${ALSA_DIR}:$LD_LIBRARY_PATH"
fi

# Find JACK library in nix store (optional, for better audio)
JACK_LIB=$(find /nix/store -name "libjack.so.0" 2>/dev/null | head -1)
if [ -n "$JACK_LIB" ]; then
    JACK_DIR=$(dirname "$JACK_LIB")
    export LD_LIBRARY_PATH="${JACK_DIR}:$LD_LIBRARY_PATH"
fi

# Run the actual server
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec node "${SCRIPT_DIR}/dist/index.js" "$@"
