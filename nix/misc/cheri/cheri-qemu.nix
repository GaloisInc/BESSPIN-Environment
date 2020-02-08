{ qemu, fetchFromGitHub }:

let 
  
  targets = [
    "cheri256-softmmu"
    "cheri128-softmmu"
    "cheri128magic-softmmu"
    "mips64-softmmu"
    "riscv64-softmmu"
    "riscv32-softmmu"
  ];

in (qemu.override {

  xenSupport = false;
  sdlSupport = false;
  gtkSupport= false;
  vncSupport = false;
  openGLSupport = false;
  virglSupport = false;
  smbdSupport = true;
  pulseSupport = false;
  hostCpuTargets = targets;

}).overrideAttrs (old: {
  
  version = "4.1.92-cheri";
  
  src = fetchFromGitHub {
    owner = "CTSRD-CHERI";
    repo = "qemu";
    rev = "74235a2879944724c88ad8b400170b8e2b0a6147";
    sha256 = "1vnd9hlh3h71y1qjvk7p5x4jdv8hiygl2wjwwgrrmyqljh5y0yk9";
    fetchSubmodules = true;
  }; 
  
  patches = [ ./no-etc-install.patch ];
  
})
   

