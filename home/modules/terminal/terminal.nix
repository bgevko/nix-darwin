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

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if test -f "${dotfiles}/profiles/common.fish"
        source "${dotfiles}/profiles/common.fish"
      end
    '';
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
