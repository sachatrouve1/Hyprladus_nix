{
  config,
  pkgs,
  lib,
  ...
}: {
  users.users.sacha.extraGroups = [
    "docker"
  ];
  virtualisation.docker.enable = true;
}
