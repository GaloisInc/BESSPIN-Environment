{ stdenv, fetchGit2, bash, jdk, jre, alloy }:

let
  alloyJar = "${alloy}/share/alloy/alloy4.jar";

in stdenv.mkDerivation rec {
  name = "alloy-check";
  src = "./";

  buildInputs = [ jdk ];

  buildPhase = ''
    ALLOY_JAR=${alloyJar} bash ./build.sh
  '';

  installPhase = ''
    mkdir -p $out/lib/alloy-check
    cp *.class $out/lib/alloy-check

    mkdir -p $out/bin
    substitute '${./alloy-check}' "$out/bin/alloy-check" \
      --subst-var-by out "$out" \
      --subst-var-by bash '${bash}' \
      --subst-var-by alloyJar '${alloyJar}' \
      --subst-var-by jre '${jre}'
    chmod +x $out/bin/alloy-check
  '';
}
