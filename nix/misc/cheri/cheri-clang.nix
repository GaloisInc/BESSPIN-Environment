{ stdenv, ninja, fetchFromGitHub, llvmPackages }:

let
        llvmVersion = "9.0.0-cheri";

	fetchTarball = name: repo: rev: sha256:
          stdenv.mkDerivation {
            name = "${repo}-src-${rev}.tar.gz";
            src = fetchFromGitHub {
              owner = "CTSRD-CHERI";
              inherit repo rev sha256;
            };
          phases = ["unpackPhase" "installPhase"];
          installPhase = ''
            mv clang llvm/tools/ 
            mv lld llvm/tools/
            mv llvm ${name}-${llvmVersion}
            tar -czf $out ${name}-${llvmVersion}
          '';
        };

  fetch = name: sha256: 
    fetchTarball name "llvm-project" "0942b96ff6228838a3614b6918f64a9ba9fcd484" "1f3c6ryd2bg1l3j2b5170q0zly74bsj40f429dnbjfyc8bpy3sqv";

in 
  (llvmPackages.llvm.override {
    version = llvmVersion;
    enableSharedLibraries = false;
    inherit fetch;
  }).overrideAttrs(old: {
      installPhase = '''';
      cmakeFlags = [ 
        "-G Ninja"
        "-DCMAKE_BUILD_TYPE:STRING=Release"
        "-DBUILD_SHARED_LIBS=ON" 
        "-DLLVM_ENABLE_ASSERTIONS=On" 
        "-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=RISCV" 
        ];
      postInstall = ''
        mkdir -p $python/share
        mv $out/share/opt-viewer $python/share/opt-viewer
        ln -s $out/bin/clang $out/bin/riscv32-unknown-elf-clang
        ln -s $out/bin/ld.lld $out/bin/riscv32-unknown-elf-ld
      '';
      buildInputs = old.buildInputs ++ [ninja];
      doCheck = false;
  })