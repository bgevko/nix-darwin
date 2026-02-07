{ ... }:

let
  user = "bgevko";
  home = "/Users/${user}";
  defaultWallpaper = "${home}/nixos/configs/walls/wall4-adj.png";
in
{
  imports = [
    ../common/configuration.nix
  ];

  # Machine-specific hardware/platform
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Dock (home layout)
  system.defaults.dock.persistent-apps = [
    { app = "/Applications/Raycast.app"; }
    { app = "/Applications/Leader Key.app"; }
    { app = "/Applications/AeroSpace.app/"; }
    { app = "/Applications/Nix Apps/kitty.app/"; }
    { app = "/Applications/Brave Browser.app/"; }
  ];

  # Launchd services (home)
  launchd.user.agents.setWallpaper = {
    serviceConfig = {
      Label = "setWallpaper";
      ProgramArguments = [
        "/usr/bin/osascript"
        "-e"
        ''tell application "System Events" to set picture of every desktop to "${defaultWallpaper}"''
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };

  launchd.user.agents = {
    raycast.serviceConfig = {
      Label = "com.raycast.launcher";
      ProgramArguments = [
        "/usr/bin/open"
        "-a"
        "/Applications/Raycast.app"
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };

    leaderkey.serviceConfig = {
      Label = "com.leaderkey.launcher";
      ProgramArguments = [
        "/usr/bin/open"
        "-a"
        "/Applications/Leader Key.app"
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };

    aerospace.serviceConfig = {
      Label = "com.aerospace.launcher";
      ProgramArguments = [
        "/usr/bin/open"
        "-a"
        "/Applications/AeroSpace.app"
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };

    ssh_add.serviceConfig = {
      Label = "com.user.ssh_add";
      ProgramArguments = [
        "/usr/bin/ssh-add"
        "--apple-use-keychain"
        "$~/.ssh/ssh-github-personal"
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };
}
