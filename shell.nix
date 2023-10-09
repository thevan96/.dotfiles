{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ gnumake stow nodePackages.prettier stylua ];
}
