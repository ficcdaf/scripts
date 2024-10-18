# Daniel's Utility Scripts

This is a small collection of various utility scripts I have written for myself. I may document them but no guarantees.

## keyd

I use a utility called `keyd` to provide a system-level keyboard remapping. `keyd` supports layers, arbitrary key remapping, and filtering by hardware ID, which makes it perfect for my use case of applying my colemak-dh layout and productivity macros to my laptop's internal keyboard.

The `update.sh` script is very simple: Assuming that `keyd` is already running (through `systemd`), it will read the current configuration, append it to the backup file, overwrite the configuration with the user updated version, and restarts the daemon.
