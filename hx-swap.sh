#!/bin/bash

if [[ "$1" == "master" || "$1" == "axel" ]]; then
  rm /home/fic/.cargo/bin/hx
  cd /home/fic/dev/helix-"$1" || exit
  cargo install --locked --path helix-term
  ln -sf /home/fic/dev/helix-"$1"/runtime /home/fic/.cargo/bin
else
  echo "Arg must be 'master' or 'axel'!"
fi
