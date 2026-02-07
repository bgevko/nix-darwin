{
  inputs,
  config,
  pkgs,
  ...
}:
let
  nixDir = "${config.home.homeDirectory}/nixos";
  dotfiles = "${nixDir}/configs";
  app_support = "Library/Application Support";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ./modules/terminal/terminal.nix
    inputs.stylix.homeModules.stylix
  ];

  home.username = "bgevko";
  home.homeDirectory = "/Users/bgevko";
  home.stateVersion = "25.05";

  stylix = {
    enable = true;
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
    "/usr/local/clamav/bin"
    "/usr/local/clamav/sbin"
    "${config.home.homeDirectory}/.local/share/pnpm"
    "${config.home.homeDirectory}/.local/bin"
    "${nixDir}/bin"
  ];

  home.sessionVariables = {
    NIX_DIR = nixDir;
    NIX_DOTFILES = dotfiles;
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };

  programs.home-manager.enable = true;
}
