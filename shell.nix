{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    stylua
    gnumake
    nodePackages_latest.prettier
  ];
}
