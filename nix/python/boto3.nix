{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "boto3";
  version = "1.14.57";

  doCheck = false;
  propagatedBuildInputs = [ botocore s3transfer jmespath ];
  
  src = fetchPypi {
    inherit pname version;
    sha256 = "e5cbd8b751bd498f275b0582f449f92f14e64f4e03b5bf51c571240d40d43561";
  };

  meta = with lib; {
  homepage = https://github.com/boto/boto3;
  description = "Amazon Web Services (AWS) Software Development Kit (SDK) for Python";
  };
  
}