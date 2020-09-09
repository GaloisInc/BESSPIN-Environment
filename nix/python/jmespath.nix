{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "jmespath";
  version = "0.10.0";

  doCheck = false;
  
  src = fetchPypi {
    inherit pname version;
    sha256 = "1d2391d1ahfkfpjhr7bwv4iz5zb32mxrigk03kr6rg1s3kbc2nml";
  };

  meta = with lib; {
  homepage = https://github.com/jmespath/jmespath.py;
  description = "JMESPath allows you to declaratively specify how to extract elements from a JSON document.";
  };
  
}