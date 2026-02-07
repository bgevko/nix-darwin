{ self, pkgs, ... }:

let
  user = "bgevko";
  home = "/Users/${user}";
  defaultWallpaper = "${home}/nixos/configs/walls/wall4-adj.png";
in
{
  nix.settings.experimental-features = "nix-command flakes";
  programs.fish.enable = true;
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = user;
  users.users.bgevko = {
    name = user;
    home = home;
  };

  nixpkgs.config.alzlowUnfree = true;
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = 2.0;

  # System defaults
  system.defaults = {
    # Key repeat and speed
    NSGlobalDomain = {
      "com.apple.trackpad.scaling" = 3.0;
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false;
    };
    dock = {
      persistent-apps = [
        { app = "/Applications/Raycast.app"; }
        { app = "/Applications/Leader Key.app"; }
        { app = "/Applications/AeroSpace.app/"; }
        { app = "/Applications/Nix Apps/kitty.app/"; }
        { app = "/Applications/Brave Browser.app/"; }
      ];
    };
  };

  # Launchd services
  launchd.user.agents.setWallpaper = {
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

  launchd.user.agents = {
    raycast = {
      serviceConfig = {
        Label = "com.raycast.launcher";
        ProgramArguments = [
          "/usr/bin/open"
          "-a"
          "/Applications/Raycast.app"
        ];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };

    leaderkey = {
      serviceConfig = {
        Label = "com.leaderkey.launcher";
        ProgramArguments = [
          "/usr/bin/open"
          "-a"
          "/Applications/Leader Key.app"
        ];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };

    aerospace = {
      serviceConfig = {
        Label = "com.aerospace.launcher";
        ProgramArguments = [
          "/usr/bin/open"
          "-a"
          "/Applications/AeroSpace.app"
        ];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };

    ssh_add = {
      serviceConfig = {
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
  };

  # Packages / programs
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
    _1password-gui
    qutebrowser
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

    # HM CLI (optional, but you had it before)
    home-manager
  ];

  homebrew = {
    enable = true;

    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];

    brews = [
      # UI / WM bits
      "borders"
      "sketchybar"

      # CLI utilities
      "jq"
      "gs"
      "direnv"
      "cloc"
      "eslint_d"

      # editor
      "neovim"
    ];

    casks = [
      # window manager / launchers
      "nikitabobko/tap/aerospace"
      "leader-key"
      "raycast"

      # browsers
      "brave-browser"

      # fonts
      "font-space-mono-nerd-font"

      # apps
      "1password"
      "losslesscut"
      "postman"
      "figma"
    ];

    onActivation.cleanup = "none";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

}
