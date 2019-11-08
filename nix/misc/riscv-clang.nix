{ stdenv, lib, fetchFromGitHub2, llvmPackages_8 }:

let
  expTargets = "LLVM_EXPERIMENTAL_TARGETS_TO_BUILD";
  adjustFlags = oldFlags:
    builtins.filter
      (flag: ! (lib.hasPrefix "-D${expTargets}=" flag))
      oldFlags ++
    ["-D${expTargets}=RISCV"];

  llvmVersion = "9.0.0-git";

  fetchTarball = name: repo: rev: sha256:
    stdenv.mkDerivation {
      name = "${repo}-${llvmVersion}-src-${rev}.tar.gz";
      src = fetchFromGitHub2 {
        owner = "llvm-mirror";
        inherit repo rev sha256;
      };
      phases = [ "unpackPhase" "installPhase" ];
      installPhase = ''
        cd ..
        mv source ${name}-${llvmVersion}
        tar -czf $out ${name}-${llvmVersion}
      '';
    };

  fetch = name: sha:
    if name == "llvm" then
      fetchTarball name "llvm" "4d1e6104e6a86a0f0a31cb8d666f4c5ae7f0568c"
        "05q0x18cqzb1gp1n0w06rds6wfpdf9ww8xfp3s74r6wqc531g4md"
    else if name == "cfe" then
      fetchTarball name "clang" "d3f9eac03b57df52b2b096a70e38082c9e989c88"
        "01rjfmj5pvyvlcwmc2vb82wmgq3j4vn9r129gbw8rbghj7437p8r"
    else if name == "clang-tools-extra" then
      fetchTarball name "clang-tools-extra" "f9c42bc0523b1f43a9ec0ed41ac363aa44bbce59"
        "07yb376xkkdbhqd8wnrwaxi640zmbqi8ipg9wky1mlhlhfn7gp8y"
    else
      abort "unexpected repo in fetch: ${name}";

in rec {
  llvm = (llvmPackages_8.llvm.override {
    version = llvmVersion;
    inherit fetch;
  }).overrideAttrs (old: {
    cmakeFlags = adjustFlags old.cmakeFlags;
  });

  clang = (llvmPackages_8.clang-unwrapped.override {
    inherit llvm;
    version = llvmVersion;
    inherit fetch;
    clang-tools-extra_src = fetch "clang-tools-extra" "";
  }).overrideAttrs (old: {
    cmakeFlags = adjustFlags old.cmakeFlags;
    patches = [ ./riscv-clang-purity.patch ];
  });
}
