{ pkgs }:
rec {
  xcharter = pkgs.callPackage ./xcharter.nix { };
  glossarium = pkgs.callPackage ./glossarium.nix { };
  thesis = pkgs.callPackage ./thesis.nix { inherit xcharter glossarium; };
}
