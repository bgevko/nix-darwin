{ pkgs, osConfig, ... }:
{
  programs.fish.shellAbbrs = {
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    rebuild = "sudo darwin-rebuild switch --flake /Users/bgevko/nixos#macbook";
    conf = "nvim /Users/bgevko/nixos/hosts/macbook/configuration.nix";
    configs = "cd /Users/bgevko/nixos/configs";
    nixos = "cd /Users/bgevko/nixos";
    hm = "nvim /Users/bgevko/nixos/home/bgevko-mac.nix";
    logout = "osascript -e 'tell application \"System Events\" to log out'";
    reboot = "osascript -e 'tell application \"System Events\" to restart'";
    term = "nvim/Users/bgevko/nixos/home/modules/terminal/terminal.nix";
    aliases = "nvim /Users/bgevko/nixos/home/modules/terminal/aliases.nix";
    auth = "nvim ~/nixos/home/modules/auth.nix";
    n = "cd ~/nixos/configs/nvim/lua";
    nplug = "cd ~/nixos/configs/nvim/lua/plugins";
    nplugo = "cd ~/nixos/home/modules/neovim/plugins";
    lsp = "nvim ~/nixos/configs/nvim/lua/lsp.lua";
    keys = "nvim ~/nixos/configs/leader-key.json";
    aero = "nvim ~/nixos/configs/aerospace.toml";
  };
}
