{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "boto3";
  version = "1.14.57";

  doCheck = false;
  
  src = fetchPypi {
    inherit pname version;
    sha256 = "1d2391d1ahfkfpjhr7bwv4iz5zb32mxrigk03kr6rg1s3kbc2nml";
  };

  propagatedBuildInputs = [ jmespath ];

  meta = with lib; {
  homepage = https://github.com/boto/boto3;
  description = "Amazon Web Services (AWS) Software Development Kit (SDK) for Python";
  };
  
}
