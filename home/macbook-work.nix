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
      if test -f "${dotfiles}/profiles/work.fish"
        source "${dotfiles}/profiles/work.fish"
      end
    '';
  };

  home.sessionPath = [
    "/usr/local/mysql-8.0.39-macos14-arm64/bin"
    "/usr/local/mysql/support-files/"
  ];
}
