{
  config,
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
      if test -f "${config.home.homeDirectory}/.work_profile.fish"
        source "${config.home.homeDirectory}/.work_profile.fish"
      end
    '';
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
