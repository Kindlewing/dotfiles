#!/bin/bash

file="$(mpc --format "$HOME/Music/library"/%file% current)"
title="$(mpc --format '%title%\n%artist% - %album%' current)"

# Create temp preview paths
jpg="$(mktemp --suffix=.jpg)"
png="$(mktemp --suffix=.png)"
img=""

# Try to extract embedded cover as JPG
if ffmpeg -y -i "$file" -an -map 0:v -c:v mjpeg "$jpg" -loglevel quiet && [ -s "$jpg" ]; then
    img="$jpg"
# If that fails, create a 128x128 PNG preview
elif ffmpeg -y -i "$file" -an -vf scale=128:128 "$png" -loglevel quiet && [ -s "$png" ]; then
    img="$png"
fi

# Send notification
notify-send -r 27072 "Now Playing" "$title" ${img:+-i "$img"}

# Clean up
rm -f "$jpg" "$png"
