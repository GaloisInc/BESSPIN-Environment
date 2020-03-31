{ stdenv, aeDriverWrapper, aeExportFirrtl, graphviz
, chiselProc
, configTemplate
}:

stdenv.mkDerivation {
  name = "extracted-arch-${chiselProc.name}";
  src = chiselProc;

  buildInputs = [ aeDriverWrapper aeExportFirrtl graphviz ];

  buildPhase = ''
    substitute ${configTemplate} arch-extract.toml \
      --subst-var-by SOURCE_FILE "${chiselProc.targetName}.fir"
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
