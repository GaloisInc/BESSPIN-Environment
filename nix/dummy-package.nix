{ stdenv, name, message }:
stdenv.mkDerivation {
  inherit name;
  phases = [ "installPhase" ];
  installPhase = ''
    cat <<"EOF"
    ${message}
    EOF
  '';
}
