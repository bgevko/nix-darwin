if test -f $NIX_DOTFILES/profiles/common.fish
    source $NIX_DOTFILES/profiles/common.fish
else
    echo "Error: common.fish not found in $NIX_DOTFILES/profiles/"
end

if test -f ~/.work-profile
    source ~/.work-profile
else
    echo "Unable to source ~/.work-profile
end
