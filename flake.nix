{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };

      inherit (pkgs) fetchFromGitHub lib;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd

          php
          phpPackages.composer

          (import ./sculpin.nix {
            inherit fetchFromGitHub lib php;
          })
        ];
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
