{ pkgs, lib, ... }:
{
  nix.settings = {
    trusted-users = [ "lemon" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Canada/Eastern";

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    vim
  ];

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
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
    libraries = with pkgs; [ stdenv.cc.cc ];
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "CascadiaCode"
      ];
    })
    lxgw-wenkai
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  age.identityPaths = [ "/home/lemon/.ssh/id_ed25519" ];
  age.secrets.gitconfig = {
    file = ../secret/gitconfig-secret.age;
    mode = "770";
    owner = "lemon";
    group = "wheel";
  };
}
