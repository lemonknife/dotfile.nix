{ pkgs, ... }:
{
  # Display Manager (cosmic)
  services.displayManager.cosmic-greeter.enable = true;

  # Cosmic
  services.desktopManager.cosmic.enable = true;

  # Clipboard Support
  environment.systemPackages = with pkgs; [ wl-clipboard ];
}
