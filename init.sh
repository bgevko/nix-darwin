sudo nix run \
  --extra-experimental-features nix-command \ 
  --extra-experimental-features flakes \
  nix-darwin/master#darwin-rebuild -- switch --flake ~/nixos#macbook
