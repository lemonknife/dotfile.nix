{
  imports = [
    ./wez
  ];
  
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "CascadiaCode" ]; })
];
}
