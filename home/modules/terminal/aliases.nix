{ pkgs, osConfig, ... }:
{
  programs.fish.shellAbbrs = {
    aliases = "nvim /Users/bgevko/nixos/home/modules/terminal/aliases.nix";
    # System
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    logout = "osascript -e 'tell application \"System Events\" to log out'";
    reboot = "osascript -e 'tell application \"System Events\" to restart'";

    # NixOS / Darwin
    rebuild = "sudo darwin-rebuild switch --flake /Users/bgevko/nixos#Bogdans-MacBook-Pro";

    # Edit configs
    kittyconf = "nvim /Users/bgevko/nixos/configs/kitty/kitty.conf";
    aero = "nvim ~/nixos/configs/aerospace/aerospace.toml";
    auth = "nvim ~/nixos/home/modules/auth.nix";
    term = "nvim ~/nixos/home/modules/terminal/terminal.nix";
    lkey = "nvim ~/nixos/configs/leader-key.json";
    conf = "nvim /Users/bgevko/nixos/hosts/macbook/configuration.nix";
    hm = "nvim /Users/bgevko/nixos/home/bgevko-mac.nix";

    # CD Into ..
    nixos = "cd /Users/bgevko/nixos";
    proj = "cd ~/Projects/";
    configs = "cd /Users/bgevko/nixos/configs";
    "configs/nvim" = "cd ~/nixos/configs/nvim/lua";
    "configs/kitty" = "cd /Users/bgevko/nixos/configs/kitty";
    "configs/palettes" = "cd /Users/bgevko/nixos/configs/palettes";
    "configs/walls" = "cd /Users/bgevko/nixos/configs/walls";
    "configs/sketchybar" = "cd /Users/bgevko/nixos/configs/sketchybar";
    wos = "cd ~/Projects/web-os/";
    bb = "cd ~/.backups/bos2";

    # Neovim
    nplug = "cd ~/nixos/configs/nvim/lua/plugins";
    nopts = "nvim ~/nixos/configs/nvim/lua/opts.lua";
    nkeys = "nvim ~/nixos/configs/nvim/lua/keymaps.lua";
    ncmds = "nvim ~/nixos/configs/nvim/lua/auto_cmds.lua";
    lsp = "nvim ~/nixos/configs/nvim/lua/lsp.lua";
  };
}
