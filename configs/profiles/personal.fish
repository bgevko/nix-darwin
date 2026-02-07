# Paths
fish_add_path ~/.local/bin
fish_add_path "$(go env GOPATH)/bin"

# Direnv
direnv hook fish | source

# Do stuff
abbr -a src "source ~/nixos/configs/profiles/personal.fish"
abbr -a wp "nvim ~/nixos/configs/profiles/personal.fish"
