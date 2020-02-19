{ stdenv, lib, llvmPackages_9, fetchurl, fetchFromGitHub }:

let
  version = "11.0.0-git";

  fetchSrc = projName: archiveName: stdenv.mkDerivation rec {
    name = archiveName + "-${version}.tar.gz";
    src = fetchFromGitHub {
      owner = "llvm";
      repo = "llvm-project";
      rev = "2d146aa2a2cdef330877b511b54886823e71f92c";
      sha256 = "10q7qd15b8fpcsp91hzx83i52v8ngwws54nkk9ymz792d0ymrfjk";
    };
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mv ${projName} ${archiveName}-${version} && tar -czf $out ${archiveName}-${version}
    '';
  };

  fetch = name: sha256:
    if name == "llvm" then fetchSrc "llvm" "llvm"
    else if name == "cfe" then fetchSrc "clang" "cfe"
    else if name == "clang-tools-extra" then fetchSrc "clang-tools-extra" "clang-tools-extra"
    else if name == "lld" then fetchSrc "lld" "lld"
    else if name == "polly" then fetchSrc "polly" "polly"
    else
      abort "unexpected repo in fetch: ${name}";

in rec {
  llvm = (llvmPackages_9.llvm.override {
    inherit version fetch;
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
    inherit llvm version fetch;
    clang-tools-extra_src = fetch "clang-tools-extra" "";
  }).overrideAttrs (old: {
    patches = [ ./riscv-clang-purity.patch ];

    # LLVM 10 and later use c++14
    cmakeFlags = [
      "-DCMAKE_CXX_FLAGS=-std=c++14"
      "-DCLANGD_BUILD_XPC=OFF"
    ];

    # The clang derivation in nixpkgs makes some changes to the driver
    # in the postPatch phase which prevent clang from searching for
    # headers using the standard system paths like
    # /usr/include. Unfortunately these changes make clang ignore the
    # --sysroot option, which we need for cross compilation
    postPatch = "";
  });

  lld = llvmPackages_9.lld.override {
    inherit llvm version fetch;
  };
}
