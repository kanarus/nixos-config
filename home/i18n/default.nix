{ pkgs, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc-ut
        fcitx5-fluent
      ];
      settings = {
        inputMethod = {
          "GroupOrder" = {
            "0" = "Default";
          };
          "Groups/0" = {
            "Name" = "Default";
            "Default Layout" = "us";
            "DefaultIM" = "mozc";
          };
          "Groups/0/Items/0" = {
            "Name" = "keyboard-us";
            "Layout" = "";
          };
          "Groups/0/Items/1" = {
            "Name" = "mozc";
            "Layout" = "";
          };
        };
        addons = {
          classicui = {
            globalSection = {
              "Theme" = "FluentDark";
            };
          };
        };
      };
    };
  };

  home.packages = [
    (pkgs.writeShellApplication {
      # `fcitx5-mozc-ut` is just `fcitx5-mozc.override { mozc = mozc-ut }`.
      # (https://github.com/NixOS/nixpkgs/blob/main/pkgs/by-name/fc/fcitx5-mozc-ut/package.nix)
      name = "mozc-config";
      text = "${pkgs.mozc-ut}/lib/mozc/mozc_tool --mode=config_dialog";
    })
  ];
}
