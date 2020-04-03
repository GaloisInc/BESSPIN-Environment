{ stdenv, aeDriverWrapper, aeExportBsv, graphviz
, bluespecProcSrc
, variant
, configTemplate
}:

stdenv.mkDerivation {
  name = "extracted-arch-bluespec-${variant}";
  src = bluespecProcSrc;

  buildInputs = [ aeDriverWrapper aeExportBsv graphviz ];

  buildPhase = ''
    cp ${configTemplate} arch-extract.toml
    besspin-arch-extract arch-extract.toml visualize
    for f in out/*.dot; do
      # Hack: some modules take a long time to render, so we just skip them.
      timeout 10 dot -Tpdf "$f" -o "''${f%.dot}.pdf" || true
    done
  '';

  installPhase = ''
    mkdir $out
    mv out/* $out
  '';
}
