{
  config,
  ...
}:
let
  nixDir = config.home.sessionVariables.NIX_DIR;
in
{
  imports = [ ./common.nix ];

  # home-only overrides
  home.sessionPath = [
    "${nixDir}/configs/profiles/home.fish"
  ];
}
