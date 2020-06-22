{ lib
, buildPythonPackage
, fetchPypi
, cffi
, zstd
}:

buildPythonPackage rec {
  pname = "zstandard";
  version = "0.13.0";

  doCheck = false;
  
  src = fetchPypi {
    inherit pname version;
    sha256 = "e5cbd8b751bd498f275b0582f449f92f14e64f4e03b5bf51c571240d40d43561";
  };
  
  propagatedBuildInputs = [ cffi zstd ];
  
}
