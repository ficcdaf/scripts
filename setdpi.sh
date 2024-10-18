#!/bin/bash

EXTERNAL_MONITOR="3840x2160"
DPI_WITH_EXTERNAL=140   # DPI when the external monitor is connected
DPI_WITHOUT_EXTERNAL=96 # DPI when the external monitor is not connected

# Check if the external monitor is connected
if xrandr | grep -q $EXTERNAL_MONITOR; then
  echo "Xft.dpi: $DPI_WITH_EXTERNAL" >~/.Xresources
  autorandr -l lab
else
  echo "Xft.dpi: $DPI_WITHOUT_EXTERNAL" >~/.Xresources
  autorandr -l default
fi
xrdb -merge ~/.Xresources
nitrogen --restore
