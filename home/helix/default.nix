{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    helix
    wl-clipboard
  ];

  home.file = {
    "${config.xdg.configHome}/helix/config.toml".source = ./config.toml;
    "${config.xdg.configHome}/helix/ignore".source = ./ignore;
  };
}
