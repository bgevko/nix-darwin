{ config, ... }:
let
  nixDir = config.home.sessionVariables.NIX_DIR;
  dotfiles = config.home.sessionVariables.NIX_DOTFILES;
in
{
  programs.fish.shellAbbrs = {
    aliases = "nvim /Users/bgevko/nixos/home/modules/terminal/aliases.nix";
    # System
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    logout = "osascript -e 'tell application \"System Events\" to log out'";
    reboot = "osascript -e 'tell application \"System Events\" to restart'";

    # Edit configs
    kittyconf = "nvim ${dotfiles}/kitty/kitty.conf";
    aero = "nvim ${dotfiles}/aerospace/aerospace.toml";
    auth = "nvim ${nixDir}/home/modules/auth.nix";
    confc = "nvim /Users/bgevko/nixos/hosts/common/configuration.nix";

    # CD Into ..
    nixos = "cd ${nixDir}";
    proj = "cd ~/Projects/";
    configs = "cd ${dotfiles}/";

    # Neovim
    nplug = "cd ${dotfiles}/nvim/lua/plugins";
    nopts = "nvim ${dotfiles}/nvim/lua/opts.lua";
    nkeys = "nvim ${dotfiles}/nvim/lua/keymaps.lua";
    ncmds = "nvim ${dotfiles}/nvim/lua/auto_cmds.lua";
    lsp = "nvim ${dotfiles}/nvim/lua/lsp.lua";
    hmc = "nvim ${nixDir}/home/common.nix";
    wpc = "nvim ${dotfiles}/profiles/common.fish";
  };
}
