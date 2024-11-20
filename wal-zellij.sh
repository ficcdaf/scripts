#!/bin/sh

. "$HOME/.cache/wal/colors.sh"

F="./pywal.kdl"

rm ./pywal.kdl

echo "themes {" >>"$F"
echo "    default {" >>"$F"
echo "        fg \"$color0\"" >>"$F"
echo "        bg \"$color1\"" >>"$F"
echo "        black \"$foreground\"" >>"$F"
echo "        red \"$color2\"" >>"$F"
echo "        green \"$color3\"" >>"$F"
echo "        yellow \"$color4\"" >>"$F"
echo "        blue \"$color5\"" >>"$F"
echo "        magenta \"$color6\"" >>"$F"
echo "        cyan \"$color7\"" >>"$F"
echo "        white \"$color8\"" >>"$F"
echo "        orange \"$color9\"" >>"$F"
echo "    }" >>"$F"
echo "}" >>"$F"
