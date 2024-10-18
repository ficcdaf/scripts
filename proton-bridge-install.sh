#!/bin/bash

# strict mode; exit on any error
set -euo pipefail

cleanup() {
  echo "Cleaning up..."
  rm -rf /tmp/bridge-build
}

# we set the cleanup function to run on any exit or error
trap cleanup ERR EXIT

# we make a temporary build folder and enter it
TEMP=/tmp/bridge-build
mkdir $TEMP && cd $TEMP || exit # quit incase cd fails

# we obtain the latest PKGBUILD
wget https://proton.me/download/bridge/PKGBUILD
makepkg -s --install
