{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self
    , nixpkgs
    , flake-utils
    , pre-commit-hooks
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs; {
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              typstyle.enable = true;
            };
          };
        };

        devShells.default = mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;

          nativeBuildInputs = [
            self.checks.${system}.pre-commit-check.enabledPackages
            typst
            typstyle
            tinymist
          ];

          TYPST_FONT_PATHS = pkgs.symlinkJoin {
            name = "typst-fonts";
            paths = with pkgs; [
              noto-fonts
              open-sans
            ];
          };
        };
      }
    );
}
