if test -f $NIX_DOTFILES/profiles/common.fish
    source $NIX_DOTFILES/profiles/common.fish
else
    echo "Error: common.fish not found in $NIX_DOTFILES/profiles/"
end

# Do stuff
abbr -a src "source ~/nixos/configs/profiles/home.fish"
abbr -a wp "nvim ~/nixos/configs/profiles/home.fish"

# cd into stuff
abbr -a wos "cd ~/Projects/web-os/"
