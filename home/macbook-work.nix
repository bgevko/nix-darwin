# work-only overrides
{
  config,
  ...
}:
let
  nixDir = config.home.sessionVariables.NIX_DIR;
  dotfiles = config.home.sessionVariables.NIX_DOTFILES;
in
{
  imports = [ ./common.nix ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      atuin init fish | source
      if test -f "${dotfiles}/profiles/work.fish"
        source "${dotfiles}/profiles/work.fish"
      end
    '';

    shellAbbrs = {
      hm = "nvim ${nixDir}/home/macbook-work.nix";
      conf = "nvim ${nixDir}/hosts/macbook-work/configuration.nix";
    };
  };

  home.sessionVariables = {
    NIX_HOST = "work";
  };

  home.sessionPath = [
    "/usr/local/mysql-8.0.39-macos14-arm64/bin"
    "/usr/local/mysql/support-files/"
  ];
}
