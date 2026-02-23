{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ghostty
  ];

  home.file = {
    "${config.xdg.configHome}/ghostty/config".source = ./config;
  };
}
