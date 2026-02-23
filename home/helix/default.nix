{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    helix
    wl-clipboard
  ];

  home.file = {
    "${config.xdg.configHome}/helix/config.toml".source = ./config.toml;
  };
}
