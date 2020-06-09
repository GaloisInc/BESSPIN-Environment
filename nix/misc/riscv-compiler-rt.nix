{ stdenv
, cmake
, riscv-clang
, riscv-llvm
, riscv-newlib
, ninja
, python3
, fetchFromGitHub
, riscvArch ? "riscv64" }:

let archFlags = if riscvArch == "riscv64" then "-march=rv64imac -mabi=lp64" else "-march=rv32im -mabi=ilp32";
    triple = if riscvArch == "riscv64" then "riscv64-unknown-elf" else "riscv32-unknown-elf";
    flags = "-target ${triple} ${archFlags} -mcmodel=medany -mno-relax";
in stdenv.mkDerivation {
  name = "riscv-compiler-rt";

  src = fetchFromGitHub {
    owner = "llvm";
    repo = "llvm-project";
    rev = "49e20c4c9efe1c0e74f9c0dc224a8014b93faa3c";
    sha256 = "11h16cwgkg3zk9p2s7g256ln23fx7y65isyhph3ycjn6b128a582";
  };
  
  buildInputs = [
    ninja
    python3
    cmake
  ];
 
  configurePhase = ''
    mkdir build
    cd build
    cmake -G Ninja \
      -DCMAKE_C_COMPILER=${riscv-clang}/bin/clang \
      -DCMAKE_CXX_COMPILER=${riscv-clang}/bin/clang++ \
      -DCMAKE_AR=${riscv-llvm}/bin/llvm-ar \
      -DCMAKE_NM=${riscv-llvm}/bin/llvm-nm \
      -DCMAKE_RANLIB=${riscv-llvm}/bin/llvm-ranlib \
      -DLLVM_CONFIG_PATH=${riscv-llvm}/bin/llvm-config \
      -DCMAKE_C_FLAGS="${flags}" \
      -DCMAKE_CXX_FLAGS="${flags}" \
      -DCMAKE_ASM_FLAGS="${flags}" \
      -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY \
      -DCMAKE_SYSROOT=${riscv-newlib}/${triple} \
      -DCOMPILER_RT_DEFAULT_TARGET_ARCH=${riscvArch} \
      -DCOMPILER_RT_DEFAULT_TARGET_TRIPLE=${triple} \
      -DCOMPILER_RT_OS_DIR=baremetal \
      -DCOMPILER_RT_BAREMETAL_BUILD=ON \
      -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
      -DCOMPILER_RT_BUILD_XRAY=OFF \
      -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
      -DCOMPILER_RT_BUILD_PROFILE=OFF \
      ../compiler-rt
  '';

  buildPhase = ''
    cmake --build .
  '';

  installPhase = ''
    mkdir -p $out/${triple}/lib
    cp lib/baremetal/libclang_rt.builtins-${riscvArch}.a $out/${triple}/lib
  '';

  dontFixup = true;
}
