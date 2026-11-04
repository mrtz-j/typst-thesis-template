# Typst Universe packages not yet available in nixpkgs' `typstPackages`.
# Attribute names follow nixpkgs' `<name>_<version>` scheme, so an entry can be
# dropped once nixpkgs ships it without touching consumers.
final: prev: {
  typstPackages = prev.typstPackages.overrideScope (
    finalTypst: _: {
      codly_2_0_0 = final.buildTypstPackage {
        pname = "codly";
        version = "2.0.0";
        src = final.fetchzip {
          url = "https://packages.typst.org/preview/codly-2.0.0.tar.gz";
          hash = "sha256-uXwjpob7mzpGFtnFtaOzmvsfHfvWSEAmxY7i9CRNLe8=";
          stripRoot = false;
        };
        typstDeps = [ finalTypst.elembic_1_1_1 ];
        meta = {
          description = "Code blocks for Typst with line numbers, annotations, themes, and syntax-aware diffs";
          homepage = "https://github.com/Dherse/codly";
          license = final.lib.licenses.mit;
        };
      };
    }
  );
}
