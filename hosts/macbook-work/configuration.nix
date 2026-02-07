{ ... }:
{
  imports = [
    ../macbook-home/configuration.nix
  ];

  homebrew = {
    enable = true;
    taps = [
      "hashicorp/tap"
    ];
    brews = [
      "fnm"
      "hashicorp/tap/vault"
    ];
    casks = [
      "codex"
    ];
    onActivation.cleanup = "none";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
