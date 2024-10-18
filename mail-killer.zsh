#!/bin/zsh
# -2 flag sends SIGINT for a cleaner exit
pkill -f "bridge"
pkill -f birdtray
pkill -f "thunderbird"
