{ pkgs, ... }:
{
  # Display Manager (cosmic)
  services.displayManager.cosmic-greeter.enable = true;

  # Cosmic
  services.desktopManager.cosmic.enable = true;

  # Clipboard Support
  environment.systemPackages = with pkgs; [ wl-clipboard ];
  environment.variables = {
    COSMIC_DATA_CONTROL_ENABLED=1;
  };
}
