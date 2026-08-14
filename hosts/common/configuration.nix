{ self, pkgs, ... }:

let
  user = "bgevko";
  home = "/Users/${user}";
  defaultWallpaper = "${home}/nixos/configs/walls/wall4-adj.png";
in
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 6;

  system.primaryUser = user;
  users.users.${user} = {
    name = user;
    home = home;
  };
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = 3.0;

  system.defaults = {
    NSGlobalDomain = {
      "com.apple.trackpad.scaling" = 3.0;
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false;
    };
  };

  # Shared Launchd services
  launchd.user.agents = {
    setWallpaper = {
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

  # Packages / programs (global)
  environment.systemPackages = with pkgs; [
    # shells + core CLI
    zsh
    fish
    git
    openssh
    curl
    curl.dev

    # navigation / search
    ripgrep
    fd
    fzf
    tree
    trash-cli

    # build / system tooling
    cmake
    pkg-config
    gcc

    # dev tooling / runtimes
    nodejs_24
    pnpm
    lua
    luarocks
    tree-sitter
    go
    gopls
    gofumpt
    golangci-lint
    delve
    rustup
    pyenv

    # utilities
    lazygit
    age
    sops
    ast-grep
    imagemagick
    mermaid-cli
    tectonic
    pokemon-colorscripts-mac
    base16-schemes

    # GUI apps (nix-managed)
    kitty

    # LSPs
    lua-language-server
    bash-language-server
    nixd
    pyright
    typescript-language-server
    cmake-language-server
    tailwindcss-language-server
    vscode-json-languageserver
    marksman
    docker-language-server
    yaml-language-server
    vscode-langservers-extracted
    fish-lsp
    taplo

    # formatters / linters
    stylua
    shfmt
    isort
    black
    prettier
    prettierd
    nixfmt
    cmake-format
    rustfmt
    dockfmt
    yamlfmt
    clang-tools

    home-manager
    pandoc
  ];

  homebrew = {
    enable = true;

    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];

    brews = [
      "borders"
      "sketchybar"
      "jq"
      "yq"
      "gs"
      "neovim"
      "direnv"
      "cloc"
      "eslint_d"
      "gh"
      "cobra-cli"
      "tree-sitter-cli"
      "fish-lsp"
      "httpie"
      "oven-sh/bun/bun"
      "tsc"
      "sql-language-server"
      "sqlfluff"
      "yarn"
      "atuin"
      "openspec"
      "k9s"
      "glow"
      "jdtls"
      "goolge-java-format"
    ];

    casks = [
      "nikitabobko/tap/aerospace"
      "leader-key"
      "raycast"
      "brave-browser"
      "font-space-mono-nerd-font"
      "losslesscut"
      "postman"
      "figma"
      "codex"
      "1password"
    ];

    onActivation.cleanup = "none";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
