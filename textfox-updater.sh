#!/bin/bash

# FF_DIR="$HOME/.mozilla/firefox/*default*/"
FF_DIR=$(eval echo "$HOME/.mozilla/firefox/*default-release*/")
# echo "$FF_DIR" && exit
cd ~/dev/textfox/ || exit
git fetch && git pull
cp -rf chrome "$FF_DIR"
cp -r user.js "$FF_DIR"
