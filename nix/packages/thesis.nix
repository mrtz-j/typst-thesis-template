{
  pkgs,
  xcharter,
}:
let
  fontPackages = with pkgs; [
    noto-fonts
    open-sans
    jetbrains-mono
    xcharter
  ];
in
pkgs.buildTypstDocument rec {
  name = "modern-uit-thesis";
  src = ./../..;
  file = "template/thesis.typ";
  typstEnv = (
    p: [
      p.codly_1_3_0
      p.ctheorems_1_1_3
      p.glossarium_0_5_3
      p.physica_0_9_5
      p.subpar_0_2_2
    ]
  );
  fonts = fontPackages;
  format = "pdf";

  # TODO(mrtz): Upstream to nixpkgs
  buildPhase = ''
    runHook preBuild
    mkdir -p $out
    typst c ${file} --root ./ -f ${format} $out/thesis.pdf
    runHook postBuild
  '';
}
