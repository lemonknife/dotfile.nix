{ inputs, pkgs, ... }:
{
  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = [
    pkgs.via
    inputs.agenix.packages.x86_64-linux.default
  ];

  services.pcscd.enable = true;
  services.v2raya.enable = true;
  services.udev.packages = [ pkgs.via ];
  services.dbus.packages = [ pkgs.gcr ];
}
