{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (rust-bin.nightly.latest.default.override { extensions = [ "rust-src" ]; })
    evcxr
    micromamba
    cmake
    clang
    clang-tools
    bear
    jdk11
  ];
}
