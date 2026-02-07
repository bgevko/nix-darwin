# home-only overrides
{
  config,
  ...
}:
let
  nixDir = config.home.sessionVariables.NIX_DIR;
  dotfiles = config.home.sessionVariables.NIX_DOTFILES;
in
{
  imports = [
    ./common.nix
    ./modules/auth.nix
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if test -f "${dotfiles}/profiles/home.fish"
        source "${dotfiles}/profiles/home.fish"
      end
    '';

    shellAbbrs = {
      hm = "nvim ${nixDir}/home/macbook-home.nix";
      conf = "nvim ${nixDir}/hosts/macbook-home/configuration.nix";
    };
  };

  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    NIX_HOST = "home";
  };

  home.sessionPath = [
  ];
}
