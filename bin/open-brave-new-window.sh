#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Open Brave New Window
# @raycast.mode silent
# @raycast.packageName Custom Scripts
osascript <<EOF
tell application "Brave Browser"
    activate
    make new window
end tell
EOF
