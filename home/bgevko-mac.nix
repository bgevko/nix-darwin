{
  config,
  pkgs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos/configs";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    kitty = "kitty";
    nvim = "nvim";
    aerospace = "aerospace";
    leader-key = "leader-key"; # Not app default
    borders = "borders";
    sketchybar = "sketchybar";
  };
in
{
  imports = [
    ./modules/terminal/terminal.nix
    ./modules/auth.nix
  ];
  home.username = "bgevko";
  home.homeDirectory = "/Users/bgevko";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    lazygit
    age
    _1password-gui
    sops
    tree
    gcc
    trash-cli
  ];
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.sessionPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };

  programs.home-manager.enable = true;
}
