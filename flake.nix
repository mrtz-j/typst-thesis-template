{
  nixConfig = {
    extra-substituters = "https://cache.garnix.io";
    extra-trusted-public-keys = "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    press = {
      url = "github:RossSmyth/press";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.treefmt-nix.flakeModule ];
      perSystem =
        {
          system,
          config,
          pkgs,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ (import inputs.press) ];
          };

          treefmt = {
            programs = {
              nixfmt.enable = true;
              typstyle.enable = true;
            };
          };

          packages = import ./nix/packages { inherit pkgs; } // {
            default = config.packages.thesis;
          };

          devShells.default = pkgs.mkShell {
            name = "thesis";
            packages = with pkgs; [
              # Typst
              typst
              typstyle
              tinymist

              # Utils
              treefmt
              typos
              typship
              sd
            ];

            TYPST_FONT_PATHS = pkgs.symlinkJoin {
              name = "typst-fonts";
              paths = with pkgs; [
                noto-fonts
                open-sans
                jetbrains-mono
                config.packages.xcharter
              ];
            };
          };
        };
    };
}
