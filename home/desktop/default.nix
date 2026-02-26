{ config, pkgs, ... }:
let
  cursorTheme = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 24;
  };
in
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
    "${config.xdg.configHome}/niri/config.kdl".source = ./niri-config.kdl;
    "${config.xdg.configHome}/waybar/style.css".source = ./waybar-style.css;
    "${config.xdg.configHome}/waybar/config.jsonc".source = ./waybar-config.jsonc;
    "${config.xdg.configHome}/waybar/powermenu.xml".source = ./waybar-powermenu.xml;
    "${config.xdg.dataHome}/wallpaper/default.png".source = ../../assets/nix-wallpaper-gear.png;
  };

  home.pointerCursor = cursorTheme // {
    enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    inherit cursorTheme;
    theme = {
      package = pkgs.graphite-gtk-theme;
      name = "Graphite-Dark";
    };
    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid-Dark";
    };
    font = {
      name = "UDEV Gothic 35NF";
    };
    colorScheme = "dark";
  };
}
