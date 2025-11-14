{
  pkgs,
  ...
}:
{
  imports = [
    ./aliases.nix
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      cd ~/nixos
    '';
  };
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
