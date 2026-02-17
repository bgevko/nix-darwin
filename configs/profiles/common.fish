# Go
set -gx GOPATH (go env GOPATH)
fish_add_path $GOPATH/bin

# Direnv
direnv hook fish | source

# Do stuff
abbr -a wpc "nvim $NIX_DOTFILES/profiles/common.fish"
abbr -a lg lazygit
abbr -a jsnip "nvim $NIX_DOTFILES/nvim/lua/snippets/javascript.json"

# Cd into
abbr -a rem "cd ~/Projects/reman"
