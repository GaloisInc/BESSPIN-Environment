{ lib, fetchPypi, buildPythonPackage }:

buildPythonPackage rec {
  version = "0.8.0";
  pname = "tftpy";

  doCheck = false;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1zjgamgm7d2p11w7k2yrc9avwaiqqgd53qhpay390mhj41j5y2f9";
  };

  meta = {
    homepage = "https://github.com/msoulier/tftpy";
    description = "Pure Python TFTP library";
    license = lib.licenses.mit;
  };
}
