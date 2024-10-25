#!/bin/sh

N="$1"
counter=0

while IFS= read -r line; do
  if [ "$counter" -eq "$N" ]; then
    echo "$line"
    pass=$(echo "$line" | tr -d '\n')
  fi
  counter=$((counter + 1))
done <./pass_bandit.txt

# sshpass -p "$pass" echo \"ssh -p 2220 bandit"${N}"@bandit.labs.overthewire.org\"
sshpass -p "$pass" ssh -p 2220 bandit"${N}"@bandit.labs.overthewire.org
