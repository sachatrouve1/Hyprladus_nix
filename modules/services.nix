{ config, pkgs, ... } :
{
  services.playerctld.enable = true;
  services.dbus.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  services.throttled.enable = true;

  # services.smartcardDev = {
  #   enable = true;
  #   enableJavaCard = true;
  #   user = "sacha";
  # };
}
