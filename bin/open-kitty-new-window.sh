#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Open Kitty New Window
# @raycast.mode silent
# @raycast.packageName Custom Scripts

osascript <<EOF
tell application "kitty"
    activate
end tell

tell application "System Events"
    tell process "kitty"
        keystroke "n" using command down
    end tell
end tell
EOF
