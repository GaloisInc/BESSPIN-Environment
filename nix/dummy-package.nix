{ stdenv }:
name:
stdenv.mkDerivation {
  inherit name;
  phases = [ "installPhase" ];
  installPhase = ''
    echo 'error: source for package `${name}` is not available'
  '';
}
