#!/bin/bash
# Usage: jellium-volume.sh [+5% | -5% | toggle]

CHANGE="$1"

SINK_ID=$(pactl list sink-inputs | awk '
  /^Sink Input #/ { id = $3; sub("#", "", id) }
  /media.name = "Jellium Desktop"/ { print id; exit }
  /application.process.binary = "jellium-desktop"/ { print id; exit }
  /application.name = "JelliumDesktop"/ { print id; exit }
')

if [ -z "$SINK_ID" ]; then
  notify-send "JelliumDesktop is not playing audio"
  exit 1
fi

case "$CHANGE" in
  toggle)
    pactl set-sink-input-mute "$SINK_ID" toggle
    ;;
  *)
    pactl set-sink-input-volume "$SINK_ID" "$CHANGE"
    ;;
esac
