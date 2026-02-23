{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    niri
    waybar
    swaybg
    swayidle
    swaylock
    xwayland-satellite
  ];

  home.file = {
    "${config.xdg.configHome}/niri/config.kdl".source = ./niri/config.kdl;
    "${config.xdg.configHome}/waybar/style.css".source = ./waybar/style.css;
    "${config.xdg.dataHome}/wallpaper/default.png".source = ../../assets/nix-wallpaper-gear.png;
  };
}
