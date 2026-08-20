{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    podman
    podman-compose
  ];

  home.file = {
    "${config.xdg.configHome}/containers/policy.json".source = ./policy.json;
  };
}
