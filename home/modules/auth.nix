{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github.com" = {
        host = "github.com"; # pattern
        hostname = "github.com"; # real host
        user = "git";
        identityFile = [ "${config.home.homeDirectory}/.ssh/ssh-github-personal" ];
        identitiesOnly = true;

        extraOptions = {
          "AddKeysToAgent" = "yes";
        };
      };

      "*" = {
        extraOptions = {
          "AddKeysToAgent" = "yes";
        };
      };
    };
  };
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets.ssh-github-personal = {
      path = "${config.home.homeDirectory}/.ssh/ssh-github-personal";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "bgevko";
      user.email = "bgevko@gmail.com";
      init.defaultBranch = "main";
      "url.git@github.com:".insteadOf = "https://github.com/";
    };
  };
}
