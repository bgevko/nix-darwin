if test -f $NIX_DOTFILES/profiles/common.fish
    source $NIX_DOTFILES/profiles/common.fish
else
    echo "Error: common.fish not found in $NIX_DOTFILES/profiles/"
end

# Do stuff
abbr -a src "source $NIX_DOTFILES/profiles/home.fish"
abbr -a wp "nvim $NIX_DOTFILES/profiles/home.fish"

# cd into stuff
abbr -a wos "cd ~/Projects/web-os/"
abbr -a boot "cd ~/Projects/web-os/src/core/boot"
abbr -a ipc "cd ~/Projects/web-os/src/core/ipc"
abbr -a vfsapi "cd ~/Projects/web-os/src/core/vfs"
abbr -a rt "cd ~/Projects/web-os/src/runtime/"
abbr -a vfs "cd ~/Projects/web-os/server/vfs/"
abbr -a shell "cd ~/Projects/web-os/server/vfs/apps/shell"
abbr -a term "cd ~/Projects/web-os/server/vfs/apps/terminal"
abbr -a server "cd ~/Projects/web-os/server/"
abbr -a mc "cd ~/Projects/web-os/src/message-channels/"
