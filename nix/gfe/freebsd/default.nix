pkgs@{stdenv
, bmake
, lib
, newScope
, overrides ? (self: super: {})
}:


let
  targets = self: rec {
    callPackage = pkgs.newScope self;
    newScope = extra: pkgs.newScope (self // extra);

    freebsdWorld = callPackage ./freebsd.nix {
      inherit bmake;
    };
    freebsdImage = callPackage ./freebsd-rootfs-image.nix { };
    freebsdKernelQemu = callPackage ./freebsd-kernel.nix {
      device = "QEMU";
    };
    freebsdKernelFpga = callPackage ./freebsd-kernel.nix {
      device = "FPGA";
    };

  };
  in lib.fix' (lib.extends overrides targets)
