{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix.overlay ];
        };
        poetryEnv = pkgs.poetry2nix.mkPoetryEnv {
          projectDir = ./.;
        };
      in
        {
          devShell = pkgs.mkShell {
            buildInputs =  [
              poetryEnv

              pkgs.poetry
            ];
          };
        });
}
