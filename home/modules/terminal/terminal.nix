{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./aliases.nix
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      cd ~/nixos
    '';
  };
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
  # programs.kitty = {
  #   enable = true;
  #   themeFile = "Midsummer Night";
  #   settings = {
  #     shell = "${pkgs.fish}/bin/fish";
  #     window_padding_width = 10;
  #     copy_on_select = "clipboard";
  #     dynamic_background_opacity = true;
  #     background_opacity = "0.9";
  #     background_blur = 10;
  #     cursor_trail = 200; # milliseconds threshold to start trail
  #     cursor_trail_decay = "0.1 0.4"; # fastest and slowest fade in seconds
  #     cursor_trail_start_threshold = 2; # minimum cells moved before trail starts
  #     cursor_trail_color = "#ffffff"; # optional: bright green trail (change as you like)
  #     hide_window_decorations = true;
  #     window_border_width = 1;
  #     active_border_color = "#00ffff";
  #     inactive_border_color = "#005757";
  #     tab_bar_style = "powerline";
  #     tab_powerline_style = "slanted";
  #     mouse_hide_wait = -3.0;
  #     scrollback_pager = "nvim -c 'set ft=log' -";
  #   };
  #   font = {
  #     name = "JetBrainsMono Nerd Font";
  #     size = 14;
  #   };
  # };
}
