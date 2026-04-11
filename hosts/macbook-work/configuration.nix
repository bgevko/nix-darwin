{ ... }:
{
  imports = [
    ../macbook-home/configuration.nix
  ];

  homebrew = {
    enable = true;
    taps = [
      "hashicorp/tap"
      "ceejbot/tap"
    ];
    brews = [
      "fnm"
      "hashicorp/tap/vault"
      "hashicorp/tap/consul"
      "python@3.11"
      "opencode"
      "alvarosanchez/tap/ocp"
      "podman"
      "tomato"
      "openjdk@21"
    ];
    casks = [
      "codex"
    ];
    onActivation.cleanup = "none";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
