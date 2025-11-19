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
    interactiveShellInit = '''';
  };
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
