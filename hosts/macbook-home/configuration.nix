{ ... }:
{
  imports = [
    ../common/configuration.nix
  ];

  # Dock (home layout)
  system.defaults.dock.persistent-apps = [
    { app = "/Applications/Raycast.app"; }
    { app = "/Applications/Leader Key.app"; }
    { app = "/Applications/AeroSpace.app/"; }
    { app = "/Applications/Nix Apps/kitty.app/"; }
    { app = "/Applications/Brave Browser.app/"; }
  ];
  homebrew = {

    brews = [
      "verilator"
    ];

    onActivation.cleanup = "none";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
