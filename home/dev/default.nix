{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rust-bin.stable.latest.default
    python313Full
    cmake
    clang
    clang-tools
    bear
  ];
}
