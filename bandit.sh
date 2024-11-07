#!/bin/sh

# Prerequisites: openssh, sshpass
# bandit.labs.overthewire.org must be a trusted host, so ssh must be used once to manually connect to the server with creds bandit0:bandit0
# Passwords: this script expects a file, pass_bandit.txt, to exist in the current working directory.
# pass_bandit.txt should contain the flag corresponding to the bandit level of the line that it's on.
# Index starts from 0, so on the FIRST line, it should say "bandit0"
# Line 2 has the flag for bandit1, etc.
# Usage: bandit.sh N, where N is the level you want to access.
# Ex: bandit.sh 0
# Will connect to bandit0 user, passing the first line of pass_bandit.txt as the password.
#
# IMPORTANT SECURITY POINT:
# DO NOT USE THIS METHOD TO LOG INTO
# ANYTHING THAT ISN'T A CTF!
# STORING PASSWORDS IN PLAINTEXT AND
# PASSING THEM AS ARGS TO sshpass IS
# A HORRIBLE IDEA!!!!

N="$1"
counter=0

while IFS= read -r line; do
  if [ "$counter" -eq "$N" ]; then
    pass=$(echo "$line" | tr -d '\n')
  fi
  counter=$((counter + 1))
done <./pass_bandit.txt

# sshpass -p "$pass" echo \"ssh -p 2220 bandit"${N}"@bandit.labs.overthewire.org\"
sshpass -p "$pass" ssh -p 2220 bandit"${N}"@bandit.labs.overthewire.org
