sudo nix run \
  --extra-experimental-features "nix-command flakes" \
  --accept-flake-config \
  github:nix-darwin/nix-darwin/master#darwin-rebuild -- \
  switch --flake "$HOME/nixos#macbook-home"
