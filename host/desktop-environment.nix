{ pkgs, ... }:
{
  # Display Manager (cosmic)
  services.displayManager.cosmic-greeter.enable = true;

  # Cosmic
  services.desktopManager.cosmic.enable = true;

  # Niri
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;

  # Gnome
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Clipboard Support
  environment.systemPackages = with pkgs; [ wl-clipboard ];
  environment.variables = {
    COSMIC_DATA_CONTROL_ENABLED = 1;
  };
}
