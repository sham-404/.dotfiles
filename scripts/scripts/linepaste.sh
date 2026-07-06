#!/bin/bash

# Give you time to release Ctrl+Alt+V
sleep 0.5

# Read clipboard and remove ONLY the final trailing newline
CLIPBOARD_TEXT=$(xclip -selection clipboard -o | perl -0777 -pe 's/\n\z//')

# Paste line by line (not character by character)
while IFS= read -r line; do
    xdotool type --delay 0 "$line"
    xdotool key Return
    sleep 0.15
done <<< "$CLIPBOARD_TEXT"
