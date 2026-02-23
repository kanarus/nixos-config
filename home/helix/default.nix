{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    helix
  ];

  home.file = {
    "${config.xdg.configHome}/helix/config.toml".source = ./config.toml;
  };
}
