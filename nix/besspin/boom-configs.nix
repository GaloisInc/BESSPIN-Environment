{ rocketChipConfigs, boom, rocket-chip-config-plugin }:


let
  boomRocketChipConfigs = rocketChipConfigs.override {
    inherit (boom) rocket-chip;
  };
in boom.overrideScalaAttrs (old: {
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
    cat ${boomRocketChipConfigs}/config-classes.txt config-classes.txt \
      >$out/config-classes.txt
    cat ${boomRocketChipConfigs}/config-fields.txt config-fields.txt \
      >$out/config-fields.txt
  '';

  passthru = (old.passthru or {}) // {
    origRocketChip = boom.rocket-chip;
    origBoom = boom;
  };
})
