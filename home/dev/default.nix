{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override { extensions = [ "rust-analyzer" ]; })
    python313Full
    cmake
    clang
    clang-tools
    bear
  ];
}
