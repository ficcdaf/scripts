#! /usr/bin/env zsh

# Based on a script by github.com/zachdaniel

# Use Zsh globbing to expand directories
folder_list=(
  $HOME/dev/*(/)
  $HOME/dev/plugins/*(/)
  $HOME/cisc/*(/)
)

# Explicitly named folders
explicit_folders=(
  $HOME/.config
)

# Combine all folders into one array
all_folders=($folder_list $explicit_folders)

# Verify folders exist
valid_folders=()
for folder in $all_folders; do
  if [[ -d $folder ]]; then
    valid_folders+=($folder)
  fi
done

# Use fzf to select a directory
selected_dir=$(printf '%s\n' "${valid_folders[@]}" | fzf --prompt="Select a folder: ")
echo "$selected_dir"
# Check if a selection was made
if [[ -n $selected_dir ]]; then
  nvim "$selected_dir"
else
exit 0
fi
