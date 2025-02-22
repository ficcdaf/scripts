#!/bin/bash

# Define the 16 basic terminal colors and their names
colors=(
  "0 Black"
  "1 Red"
  "2 Green"
  "3 Yellow"
  "4 Blue"
  "5 Magenta"
  "6 Cyan"
  "7 White"
  "8 Bright Black"
  "9 Bright Red"
  "10 Bright Green"
  "11 Bright Yellow"
  "12 Bright Blue"
  "13 Bright Magenta"
  "14 Bright Cyan"
  "15 Bright White"
)

# Loop through and print each color with its corresponding name
for color in "${colors[@]}"; do
  index=${color%% *}
  name=${color#* }
  printf "\e[48;5;%sm %2s %-12s \e[0m\n" "$index" "$index" "$name"
done

echo "\nTest complete."
