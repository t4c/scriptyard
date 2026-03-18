#!/bin/bash
#
# simple chameleon ultra flash script
#
# prerequisites:
#	cloned https://github.com/RfidResearchGroup/ChameleonUltra
#   get nrfutil not via pip! but https://www.nordicsemi.com/Products/Development-tools/nRF-Util
#   install JLink V818: https://www.segger.com/downloads/jlink/

TARGET_DIR="SETDIRECTORY/HERE/ChameleonUltra/firmware/"

# Exit immediately if a command exits with a non-zero status.
set -e

# Change to the target directory
echo "Changing to directory: ${TARGET_DIR}"
cd "${TARGET_DIR}" || { echo "Error: Could not change to directory ${TARGET_DIR}."; exit 1; }

# Run the Docker Compose build command
echo "Running Docker Compose build..."
docker compose up --pull=always build-ultra

# Run the flash script
echo "Running flash script..."
./flash-dfu-full.sh

# If everything succeeded
echo "Script completed successfully."
exit 0
