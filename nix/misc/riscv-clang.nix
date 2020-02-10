{ stdenv, lib, fetchFromGitHub2, llvmPackages_9, fetchurl }:

let
  releaseVersion = "10.0.0-rc1";
  llvmVersion = "10.0.0rc1";

  fetchRelease = name: sha256: fetchurl {
    url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-${releaseVersion}/${name}-${llvmVersion}.src.tar.xz";
    inherit sha256;
  };

  fetch = name: sha256:
    if name == "llvm" then
      fetchRelease "llvm"
        "0c77jbr7r2y57gqc8cxx8bz5p1zjl6pvsm1gajlvr77j8a5g1pia"
    else if name == "cfe" then
      fetchRelease "clang"
        "1njqwnakj73ga3fbqh6y2cmxswx998prb1m6drda3j26ss9wrw6p"
    else if name == "clang-tools-extra" then
      fetchRelease "clang-tools-extra"
        "0fpmsdsv3nc270pbv5qry6gk0sp9vnpcgw98y256n6q52m4lbcfj"
    else if name == "lld" then
      fetchRelease "lld"
        "09mfa3vl7saycj1pha9bsa1l6544yi74cqhcn2a7p5lw4k36laww"
    else if name == "polly" then
      fetchRelease "polly"
        "1i8nfx81i7rs26yw9y2yxn3fbfl48vivqg2pbwyrh8bl7v685l4p"
    else
      abort "unexpected repo in fetch: ${name}";

in rec {
  llvm = (llvmPackages_9.llvm.override {
    version = llvmVersion;
    inherit fetch;
  }).overrideAttrs (old: {
    # We only really care about cross compiling from amd64 to riscv,
    # so we can ignore most of the patches from the original package.
    postPatch = ''
      # FileSystem permissions tests fail with various special bits
      substituteInPlace unittests/Support/CMakeLists.txt \
        --replace "Path.cpp" ""
      rm unittests/Support/Path.cpp
    '';
  });

  clang = (llvmPackages_9.clang-unwrapped.override {
    inherit llvm;
    version = llvmVersion;
    inherit fetch;
    clang-tools-extra_src = fetch "clang-tools-extra" "";
  }).overrideAttrs (old: {
    #    patches = [ ./riscv-clang-purity.patch ]
    unpackPhase = ''
      unpackFile $src
      mv clang-${llvmVersion}.src* clang
      sourceRoot=$PWD/clang
      unpackFile ${fetch "clang-tools-extra" ""}
      mv clang-tools-extra-* $sourceRoot/tools/extra
    '';

    # LLVM 10 uses c++14
    cmakeFlags = [
      "-DCMAKE_CXX_FLAGS=-std=c++14"
      "-DCLANGD_BUILD_XPC=OFF"
    ];

    postPatch = "";
  });

  lld = llvmPackages_9.lld.override {
    version = llvmVersion;
    inherit llvm;
    inherit fetch;
  };
}
