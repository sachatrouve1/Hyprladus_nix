{
  pkgs,
  inputs,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
        user = "greeter";
      };
    };
  };
}
