if test -f $NIX_DOTFILES/profiles/common.fish
    source $NIX_DOTFILES/profiles/common.fish
else
    echo "Error: common.fish not found in $NIX_DOTFILES/profiles/"
end

abbr -a src "source $NIX_DOTFILES/profiles/work.fish"

if test -f ~/.work_profile.fish
    source ~/.work_profile.fish
else
    echo "Unable to source ~/.work_profile.fish"
end
