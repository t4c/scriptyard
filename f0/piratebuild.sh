#!/bin/bash
#
# simple ProtoPirate emulation patcher and compiler
#
# gets news commit from PP, "patches" emulation and builds fap
# 
#
#             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

set -e

# Ensure local bin is in PATH
export PATH="$HOME/.local/bin:$PATH"

# Configuration
REPO_URL="https://protopirate.net/ProtoPirate/ProtoPirate.git"
DIR_NAME="ProtoPirate"

# 1. Check for pipx
if ! command -v pipx &> /dev/null; then
    echo "Error: pipx is not installed."
    echo "------------------------------------------------"
    echo "Note: This script targets Debian/Ubuntu/Mint (apt)."
    echo "Install it using: apt install pipx"
    echo ""
    echo "For other distributions, use your package manager:"
    echo "Arch (AUR): yay -S python-pipx"
    echo "Fedora: dnf install pipx"
    echo "------------------------------------------------"
    exit 1
fi

# 2. Check/Install ufbt via pipx
if ! command -v ufbt &> /dev/null; then
    echo "ufbt not found."
    echo "Do you want to install ufbt via pipx now? (y/n)"
    read REPLY
    if [ "$REPLY" = "y" ] || [ "$REPLY" = "Y" ]; then
        pipx install ufbt
        pipx ensurepath
        export PATH="$HOME/.local/bin:$PATH"
    else
        echo "Error: ufbt is required. Exiting."
        exit 1
    fi
fi

# 3. Clone or Update Repo
if [ ! -d "$DIR_NAME" ]; then
    echo "Cloning from protopirate.net..."
    git clone "$REPO_URL" "$DIR_NAME"
    cd "$DIR_NAME"
else
    echo "Target directory exists. Resetting to origin..."
    cd "$DIR_NAME"
    git fetch --all
    git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
fi

# 4. Patching
echo "Patching files..."
sed -i 's/\/\/ #define ENABLE_EMULATE_FEATURE/#define ENABLE_EMULATE_FEATURE/g' defines.h 2>/dev/null

sed -i 's/gui/gui,subghz/g' application.fam

echo "Do you want to increase the stack_size in application.fam to 8 * 1024? (y/n)"
read STACK_REPLY
if [ "$STACK_REPLY" = "y" ] || [ "$STACK_REPLY" = "Y" ]; then
    sed -i 's/stack_size=2 \* 1024/stack_size=8 \* 1024/g' application.fam
    echo "Stack size increased."
fi

# 5. SDK Update & Build
echo "Updating SDK for Unleashed..."
# For Momentum, use: ufbt update --index-url https://get.momentum-fw.com/directory.json --channel dev
ufbt update --index-url https://up.unleashedflip.com/directory.json --channel dev

echo "Building FAP..."
ufbt

echo "------------------------------------------------"
echo "Done! FAP is located in: $(pwd)/dist/"
