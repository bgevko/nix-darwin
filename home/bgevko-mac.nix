{
  inputs,
  config,
  pkgs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos/configs";
  app_support = "Library/Application Support";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ./modules/terminal/terminal.nix
    inputs.stylix.homeModules.stylix # ← add this
  ];
  home.username = "bgevko";
  home.homeDirectory = "/Users/bgevko";
  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    lazygit
    age
    _1password-gui
    sops
    tree
    gcc
    trash-cli
    base16-schemes
    pokemon-colorscripts-mac
    pnpm

    # rust
    rustup

    # go
    go
    gopls
    gofumpt
    golangci-lint
    delve
  ];

  stylix = {
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest";
    base16Scheme = {
      base00 = "#2d353b";
      base01 = "#343f44";
      base02 = "#475258";
      base03 = "#a0a7a2";
      base04 = "#b1b6b2";
      base05 = "#d3c6aa";
      base06 = "#e6e2cc";
      base07 = "#fdf6e3";
      base08 = "#f89b9d";
      base09 = "#f8af8e";
      base0A = "#f3d69e";
      base0B = "#bfd69b";
      base0C = "#a2d9b0";
      base0D = "#99cfc8";
      base0E = "#ebb4ce";
      base0F = "#b2b8b4";
    };
  };
  programs.bat.enable = true;

  xdg.configFile = {
    "kitty".source = symlink "${dotfiles}/kitty";
    "nvim".source = symlink "${dotfiles}/nvim";
    "aerospace".source = symlink "${dotfiles}/aerospace";
    "borders".source = symlink "${dotfiles}/borders";
    "sketchybar".source = symlink "${dotfiles}/sketchybar";
  };

  home.file = {
    "${app_support}/Leader Key".source = symlink "${dotfiles}/leader-key";
  };

  home.sessionPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "${config.home.homeDirectory}/.local/share/pnpm"
    "/usr/local/mysql-8.0.39-macos14-arm64/bin"
    "/usr/local/mysql/support-files/"
  ];
  home.sessionVariables = {
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };

  programs.home-manager.enable = true;
}
