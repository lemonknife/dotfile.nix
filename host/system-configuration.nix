{ pkgs, lib,...}:
{
  nix.settings = {
    trusted-users = ["lemon"];
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs;[
    wget
    curl
    git
    neovim
    vim
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs;[
      stdenv.cc.cc
    ];
  };
}
