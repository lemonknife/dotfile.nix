{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rust-bin.stable.latest.default
    micromamba
    cmake
    clang
    clang-tools
    bear
  ];
}
