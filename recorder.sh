#!/bin/env bash

# depends: wf-recorder, libnotify

TEMPDIR="/tmp/recorder"
mkdir -p "$TEMPDIR"
LOCK="$TEMPDIR/lock"
RFMT=".mkv"
OFMT=".mp4"
RAW="$TEMPDIR/raw$RFMT"
OUTDIR="$HOME/Videos/wf"

function compname {
  now=$(date +"%y-%m-%d-%H:%M:%S")
  echo "$OUTDIR/$now$OFMT"
}

# First we need to check if the recording
# lockfile exists.
if [[ -f "$LOCK" ]]; then
  # process recording now
  notify-send "Stopped recording."
  # Stop the recording
  kill "$(cat "$LOCK")"
  rm "$LOCK"
  outpath="$(compname)"
  ffmpeg -y -i "$RAW" -c:v libx264 -preset slow -crf 21 -b:v 2M -maxrate 3M -bufsize 4M -c:a aac -b:a 96k -movflags +faststart "$outpath" || notify-send "Error during compression!"
  wl-copy -t 'text/uri-list' <<<"file://$outpath" || notify-send "Error during copy!"
  notify-send "Compressed recording copied to clipboard."
  rm "$RAW"

else
  # TODO: add recording status to waybar
  notify-send "Recording In Progress..."
  touch "$LOCK"
  wf-recorder -Dyf "$RAW" &
  echo "$!" > "$LOCK"
fi

