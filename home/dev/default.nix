{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override { extensions = [ "rust-src" ]; })
    evcxr
    micromamba
    cmake
    clang
    clang-tools
    bear
    openjdk11
  ];
}
