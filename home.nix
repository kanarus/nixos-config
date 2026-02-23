{ config, pkgs, inputs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11"; 
 
  programs = {
    home-manager.enable = true;
    zsh = import ./zsh;
  };
  home.packages = [
    # terminal
    pkgs.alacritty

    pkgs.symlinkJoin {
      name = "ghostty-patched";
      paths = [ pkgs.ghostty ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/ghostty --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
      '';
    }

    # editor
    pkgs.helix

    # browser
    pkgs.google-chrome

    # desktop
    pkgs.mako
    pkgs.waybar
    pkgs.swaybg
    pkgs.swayidle
    pkgs.swaylock
    pkgs.xwayland-satellite
  ];
  home.file = {
    "${config.xdg.configHome}/alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;
    "${config.xdg.configHome}/helix/config.toml".source = ./config/helix/config.toml;
    "${config.xdg.configHome}/helix/themes/kanarus.toml".source = ./config/helix/themes/kanarus.toml;
    "${config.xdg.configHome}/niri/config.kdl".source = ./config/niri/config.kdl;
    "${config.xdg.configHome}/waybar/style.css".source = ./config/waybar/style.css;
    "${config.xdg.dataHome}/wallpaper/default.png".source = ./assets/nix-wallpaper-gear.png;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };

  programs.git = {
    enable = true;
    ignores = [
      ".direnv"
    ];
    settings = {
      user = {
        name = "kanarus";
        email = "mail@kanarus.dev";
        signingKey = "5623D3EF85F1D635";
      };
      commit.gpgSign = true;
      init.defaultBranch = "main";
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = [ pkgs.fcitx5-mozc ];
      settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "mozc";
        };
        "Groups/0/Items/0" = {
          Name = "keyboard-us";
          Layout = "";
        };
        "Groups/0/Items/1" = {
          Name = "mozc";
          Layout = "";
        };
      };
    };
  };
}
