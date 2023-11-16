{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    stylua
    gnumake
    shellcheck
    nodePackages_latest.prettier
  ];
}
