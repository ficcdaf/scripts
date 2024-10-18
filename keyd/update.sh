#!/bin/bash

# We define our paths.
LOCAL=~/scripts/keyd/default.conf
BAK="$LOCAL.bak"
MAIN=/etc/keyd/default.conf

# We don't want to overwrite old backups; so we delimit each backup and
# inject the current state of the MAIN file into the backup file.
{
  echo "BAKSTART"
  cat $MAIN
  echo "BAKEND"
} >>$BAK

echo "Backup created successfully."
sudo cp -f $LOCAL $MAIN
echo "Config overwritten."
sudo keyd reload
echo "Keyd daemon reloaded. Exiting..."
