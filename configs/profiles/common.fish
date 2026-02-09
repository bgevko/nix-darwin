
# Go
set -gx GOPATH (go env GOPATH)
fish_add_path $GOPATH/bin


# Direnv
direnv hook fish | source

# Cd into
abbr -a rem "cd ~/Projects/reman"
