{ pkgs, osConfig, ... }:
{
  programs.fish.shellAbbrs = {
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    rebuild = "sudo darwin-rebuild switch --flake /Users/bgevko/nixos#Bogdans-MacBook-Pro";
    conf = "nvim /Users/bgevko/nixos/hosts/macbook/configuration.nix";
    nixos = "cd /Users/bgevko/nixos";
    hm = "nvim /Users/bgevko/nixos/home/bgevko-mac.nix";
    logout = "osascript -e 'tell application \"System Events\" to log out'";
    reboot = "osascript -e 'tell application \"System Events\" to restart'";
    term = "nvim ~/nixos/home/modules/terminal/terminal.nix";
    aliases = "nvim /Users/bgevko/nixos/home/modules/terminal/aliases.nix";
    auth = "nvim ~/nixos/home/modules/auth.nix";
    nplug = "cd ~/nixos/configs/nvim/lua/plugins";
    nopts = "nvim ~/nixos/configs/nvim/lua/opts.lua";
    nkeys = "nvim ~/nixos/configs/nvim/lua/keymaps.lua";
    ncmds = "nvim ~/nixos/configs/nvim/lua/auto_cmds.lua";
    lsp = "nvim ~/nixos/configs/nvim/lua/lsp.lua";
    keys = "nvim ~/nixos/configs/leader-key.json";
    aero = "nvim ~/nixos/configs/aerospace/aerospace.toml";
    proj = "cd ~/Projects/";

    configs = "cd /Users/bgevko/nixos/configs";
    "configs/nvim" = "cd ~/nixos/configs/nvim/lua";
    "configs/kitty" = "cd /Users/bgevko/nixos/configs/kitty";
    "kitty.conf" = "nvim /Users/bgevko/nixos/configs/kitty/kitty.conf";
  };
}
