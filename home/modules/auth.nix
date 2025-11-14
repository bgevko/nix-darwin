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

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets.ssh-github-personal = {
      path = "/home/bgevko/.ssh/ssh-github-personal";
    };
  };

  home.file.".ssh/config".text = ''
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/ssh-github-personal
      IdentitiesOnly yes
  '';
  programs.git = {
    enable = true;
    settings = {
      user.name = "bgevko";
      user.email = "bgevko@gmail.com";
      init.defaultBranch = "main";
    };
  };
}
