#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Open Chrome New Window
# @raycast.mode silent
# @raycast.packageName Custom Scripts
osascript <<EOF
tell application "Google Chrome"
    activate
    make new window
end tell
EOF
