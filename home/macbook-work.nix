{
  config,
  ...
}:
let
  nixDir = config.home.sessionVariables.NIX_DIR;
in
{
  imports = [ ./common.nix ];

  # work-only overrides
  home.sessionPath = [
    "${nixDir}/configs/profiles/work.fish"
  ];
}
