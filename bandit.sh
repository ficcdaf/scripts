#!/bin/sh

# Prerequisites: sshpass
# bandit.labs.overthewire.org must be a trusted host, so ssh must be used once to manually connect to the server with creds bandit0:bandit0

N="$1"
counter=0

while IFS= read -r line; do
  if [ "$counter" -eq "$N" ]; then
    pass=$(echo "$line" | tr -d '\n')
  fi
  counter=$((counter + 1))
done </home/fic/wargames/pass_bandit.txt

# sshpass -p "$pass" echo \"ssh -p 2220 bandit"${N}"@bandit.labs.overthewire.org\"
sshpass -p "$pass" ssh -p 2220 bandit"${N}"@bandit.labs.overthewire.org
