{ stdenv, name, message, rev ? null }:
stdenv.mkDerivation {
  inherit name rev;
  phases = [ "installPhase" ];
  installPhase = ''
    cat <<"EOF"
    ${message}
    EOF
  '';
}
