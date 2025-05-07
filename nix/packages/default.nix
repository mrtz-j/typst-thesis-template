{ pkgs }:
rec {
  xcharter = pkgs.callPackage ./xcharter.nix { };
  thesis = pkgs.callPackage ./thesis.nix { inherit xcharter; };
  typship = pkgs.callPackage ./typship.nix { };
}
