{ config, pkgs, inputs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
  imports = [
    ./modules/chrome
    ./modules/desktop
    ./modules/direnv
    ./modules/ghostty
    ./modules/git
    ./modules/helix
    ./modules/i18n
    ./modules/zsh
  ];
}
