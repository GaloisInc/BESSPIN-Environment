{ rocket-chip, rocket-chip-config-plugin }:

rocket-chip.overrideScalaAttrs (old: {
  postPatch = ''
    ${old.postPatch}
    cat >>build.sbt <<EOF
    autoCompilerPlugins := true
    addCompilerPlugin("com.galois.besspin" %% "rocket-chip-config-plugin" % "0.1.0-SNAPSHOT")
    EOF
  '';
  scalaDeps = old.scalaDeps ++ [ rocket-chip-config-plugin ];

  installPhase = ''
    echo configs:
    cat config-classes.txt
    echo
    echo fields:
    cat config-fields.txt

    mkdir $out
    cp config-classes.txt $out/
    cp config-fields.txt $out/
  '';

  passthru = (old.passthru or {}) // {
    origRocketChip = rocket-chip;
  };
})
