{ pkgs, ... }:
let
  customSddmTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "where-is-my-sddm-theme";
    version = "1.12.0";

    src = pkgs.fetchFromGitHub {
      owner = "stepanzubkov";
      repo = "where-is-my-sddm-theme";
      rev = "v1.12.0";
      hash = "sha256-";
    };
  };
in
{
  environment.systemPackages = [
    customSddmTheme
  ];
  services.displayManager.sddm = {
    enable = true;
    theme = "where_is_my_sddm_theme";
  };
}
