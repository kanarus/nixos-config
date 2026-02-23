{ pkgs, ... }:
let
  customSddmTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "where-is-my-sddm-theme";
    version = "1.12.0";

    src = pkgs.fetchFromGitHub {
      owner = "stepanzubkov";
      repo = "where-is-my-sddm-theme";
      rev = "v1.12.0";
      hash = "sha256-+R0PX84SL2qH8rZMfk3tqkhGWPR6DpY1LgX9bifNYCg=";
    };

    installPhase = ''
      substituteInPlace where_is_my_sddm_theme/theme.conf --replace 'background=' 'background=/home/kanarus/nixos-config/assets/nix-wallpaper-gear.png'
      substituteInPlace where_is_my_sddm_theme/theme.conf --replace 'font=monospace' 'font="UDEV Gothic 35NF"'
      substituteInPlace where_is_my_sddm_theme/theme.conf --replace 'helpFont=monospace' 'helpFont="UDEV Gothic 35NF"'
      mkdir -p $out/share/sddm/themes
      cp -a where_is_my_sddm_theme $out/share/sddm/themes/
    '';
  };
in
{
  environment.systemPackages = [
    customSddmTheme
  ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
  };
}
