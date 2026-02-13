{ config, pkgs, inputs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11"; 
 
  programs = {
    home-manager.enable = true;
    zsh = import ./zsh;
    helix = import ./helix;
  };
  home.packages = [
    inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.mako
    pkgs.waybar
    pkgs.swaybg
    pkgs.swayidle
    pkgs.swaylock
    pkgs.xwayland-satellite
  ];
  home.file = {
    "${config.xdg.configHome}/ghostty/config".text = builtins.readFile ./ghostty/config;
    "${config.xdg.configHome}/niri/config.kdl".text = builtins.readFile ./niri/config.kdl;
    "${config.xdg.dataHome}/wallpaper/default.png".source = ./assets/nix-wallpaper-gear.png;
  };

  # systemd.user.services = {
  #   swaybg = {
  #     Unit = {
  #       Description = "Wallpaper solution for Wayland";
  #       Documentation = "https://github.com/swaywm/swaybg";
  #       PartOf = "graphical-session.target";
  #       After = "graphical-session.target";
  #       Requisite = "graphical-session.target";
  #     };
  #     Service = {
  #       ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${wallpaper} -m fill -o *";
  #       Restart = "on-failure";
  #     };
  #     Install = {
  #       WantedBy = [ "graphical-session.target" ];
  #     };
  #   };
  # };

  # wayland.windowManager.hyprland = {
  #   enable = true;

  #   xwayland.enable = true;

  #   settings = {
  #     monitor = ",2560x1440@60,0x0,1";

  #     "$mod" = "SUPER";
  #     "$terminal" = "ghostty";
  #     "$browser" = "google-chrome-stable"; # pkg `google-chrome` provides command `google-chrome-stable`!
  #     "$menu" = "wofi --show drun";

  #     exec-once = [
  #       "sleep 5 && spice-vdagent -s /run/spice-vdagentd/spice-vdagent-sock"
  #       "wl-paste --watch cliphist store"
  #     ];

  #     general = {
  #       gaps_in = 5;
  #       gaps_out = 10;
  #       border_size = 2;
  #       "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
  #       "col.inactive_border" = "rgba(595959aa)";
  #       layout = "dwingle";
  #     };
      
  #     decoration = {
  #       rounding = 10;
  #       blur = {
  #         enabled = true;
  #         size = 3;
  #         passes = 1;
  #       };
  #     };
      
  #     bind = [
  #       "$mod, T, exec, $terminal"
  #       "$mod, B, exec, $browser"
  #       # "$mod, E, exec, dolphin"   # file manager
  #       "$mod, Space, exec, $menu" # wofi is recommended

  #       "$mod, C, killactive,"
  #       "$mod, M, exit,"
  #       "$mod, V, togglefloating,"
  #       "$mod, P, pseudo,"
  #       "$mod, J, togglesplit,"

  #       "$mod, left, movefocus, l"
  #       "$mod, right, movefocus, r"
  #       "$mod, up, movefocus, u"
  #       "$mod, down, movefocus, d"
  #     ];

  #     bindm = [
  #       "$mod, mouse:272, movewindow"
  #       "$mod, mouse:273, resizewindow"
  #     ];
  #   };
  # };  

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.google-chrome.enable = true;

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
