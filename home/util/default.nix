{ pkgs, ... }: {
  home.packages = with pkgs; [
    yazi
    blueman
    zoom-us
    pavucontrol
    evince
    podman
    podman-compose
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };
}
