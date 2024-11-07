# Add individual files, ignoring symlinks
[ ! -L "$HOME/.zshrc" ] && yadm add "$HOME/.zshrc"

# Directory navigation
cd "$HOME/.config/" || exit

# List of config directories/files to add
configs=(nvim btop dunst i3 kitty lazygit nushell polybar rofi tmux wal zathura starship.toml)

# Loop through each item in configs array
for config in "${configs[@]}"; do
  # Check if it's not a symlink before adding
  [ ! -L "$config" ] && yadm add "$config"
done

# Commit and push if there are changes
if [[ -n $(yadm status --porcelain) ]]; then
  yadm commit -m "Auto commit: $(date +'%Y-%m-%d %H:%M:%S')"
  yadm push
fi
