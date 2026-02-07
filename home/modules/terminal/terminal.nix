{
  config,
  pkgs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos/configs";
in
{
  imports = [
    ./aliases.nix
  ];
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
