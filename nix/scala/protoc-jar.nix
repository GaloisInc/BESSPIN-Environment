# We download protoc-jar as a binary package, but its .jar file includes native
# binaries that don't work inside a Nix sandbox.  The point of this package is
# to replace the binaries in the JAR with proper Nix `protoc` binaries.
{ stdenv, zip, mkBinPackage, protobuf3_5 }:

let
  jarDest = "maven/com/github/os72/protoc-jar/3.5.1.1/protoc-jar-3.5.1.1.jar";
  metaDest = "maven/com/github/os72/protoc-jar/3.5.1.1/protoc-jar-3.5.1.1.pom";

  protocVer = "3.5.1";
in stdenv.mkDerivation {
  name = "protoc-jar-3.5.1.1-patched";

  src = mkBinPackage {
    name = "protoc-jar_3_5_1_1";
    pname = "protoc-jar";
    version = "3.5.1.1";
    org = "com.github.os72";
    jarUrl = "https://repo1.maven.org/maven2/com/github/os72/protoc-jar/3.5.1.1/protoc-jar-3.5.1.1.jar";
    jarSha256 = "0pfybw92m5lp787gi5sd4k512pjkmqrqzh04b7niyya87jppzx03";
    inherit jarDest;
    metaUrl = "https://repo1.maven.org/maven2/com/github/os72/protoc-jar/3.5.1.1/protoc-jar-3.5.1.1.pom";
    metaSha256 = "02dsylk58a3yza2ryqznmxcc6z2s0n23mhxim26v8szli72r1c14";
    inherit metaDest;
  };

  buildInputs = [ zip ];

  phases = [ "buildPhase" "installPhase" ];

  buildPhase = ''
    mkdir -p bin/${protocVer}
    cp ${protobuf3_5}/bin/protoc bin/${protocVer}/protoc-${protocVer}-linux-x86_64.exe
    cp ${protobuf3_5}/bin/protoc bin/${protocVer}/protoc-${protocVer}-osx-x86_64.exe
    cp ${protobuf3_5}/bin/protoc bin/${protocVer}/protoc-${protocVer}-windows-x86_64.exe
  '';

  installPhase = ''
    install -D $src/${jarDest} $out/${jarDest}
    install -D $src/${metaDest} $out/${metaDest}

    zip -r $out/${jarDest} bin
  '';
}

