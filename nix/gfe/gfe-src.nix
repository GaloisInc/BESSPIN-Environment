{ assembleSubmodules, makeFixed }:

# This package contains the full source of the GFE, including relevant
# submodules.
#
# For many GFE dependencies, such as the `chisel3` and `firrtl` libraries, we
# want the version used in other BESSPIN tools to match the GFE version.  So
# this package also serves as the "single source of truth" for the correct git
# revisions to use.  For example, `scala/firrtl.nix` gets its sources from
# `gfeSrc.modules."chisel_processors/rocket-chip/firrtl`, so it always matches
# the GFE submodule revision, rather than hardcoding its own git revision,
# which might diverge.

let
  fetchLocal = name: rev: args: builtins.fetchGit ({
    name = "${name}-source";
    url = "${builtins.getEnv "HOME"}/work/${name}";
    inherit rev;
  } // args);

  fetchSsith = name: rev: args: builtins.fetchGit ({
    name = "${name}-source";
    url = "git@gitlab-ext.galois.com:ssith/${name}.git";
    inherit rev;
  } // args);

  fetchBluespec = name: rev: args: builtins.fetchGit ({
    name = "${name}-source";
    url = "https://github.com/bluespec/${name}.git";
    inherit rev;
  } // args);

in assembleSubmodules {
  name = "gfe-source";
  # Many GFE submodules are omitted from this list, aside from the ones that
  # are currently commented out.  This avoids wasting space and download time
  # on large sources that aren't used for any packages at the moment.
  modules = {
    "." = fetchSsith "gfe"
      "02106e532871de5db847ace7cce5912faebfa254" { ref = "develop"; };
    #"FreeRTOS-mirror" = fetchSsith "FreeRTOS-mirror"
    #  "78b056438becd61eb6023fe374c4a9dfdd1a5505" { ref = "develop"; };
    "bluespec-processors/P1/Piccolo" = fetchBluespec "Piccolo"
      "c47d309f1db1fd0e95020e83803d4649f5d119a1" {};
    "bluespec-processors/P2/Flute" = fetchBluespec "Flute"
      "c9dcf6a1ccf5b8a4b506e16a48395177e3d3bb32" { ref = "ssith"; };
    "bluespec-processors/P3/Tuba" = fetchBluespec "Tuba"
      "bb557e5e230c479359e95bc0d906bb3bec0ff669" {};
    "busybox" = makeFixed "busybox-src"
      "1m8gkay00wy7sdm7hdwyfmss9903s04bhy44xjyczyj0mn24jhwp"
      (builtins.fetchGit {
        url = "https://git.busybox.net/busybox/";
        rev = "1dd2685dcc735496d7adde87ac60b9434ed4a04c";
        ref = "1_30_stable";
      });
    "chisel_processors" = fetchSsith "chisel_processors"
      "1a7df30fc26a4f1b9ff8d2fb223b789ae3ea39fb" {};
    "chisel_processors/P3/boom-template" = fetchSsith "boom-template"
      "c93af5067727226e58c639ae8ffffe3bc8395ad0" { ref = "ssith"; };
    "chisel_processors/P3/boom-template/boom" = fetchSsith "riscv-boom"
      "539c22a878fe509fb8bd1370e737007b27bc3a28" { ref = "ssith-2.2.1"; };
    "chisel_processors/P3/boom-template/rocket-chip" = fetchSsith "rocket-chip"
      "35c6fa4983efbe85fefb0f7259fc27b832bd9dd7" { ref = "ssith-p3"; };
    "chisel_processors/rocket-chip" = fetchSsith "rocket-chip"
      "616ac6391579d60b3cf0a21c15a94ef6ccdd90a9" { ref = "ssith-p2-tv"; };
    "chisel_processors/rocket-chip/chisel3" = fetchSsith "chisel3"
      "d17be75d919d65d9831d085bd4b5ea72e53156a6" { ref = "ssith-tv"; };
    "chisel_processors/rocket-chip/firrtl" = builtins.fetchGit {
      url = "https://github.com/ucb-bar/firrtl.git";
      rev = "860e6844708e4b87ced04bcef0eda7810cba106a";
    };
    "chisel_processors/rocket-chip/hardfloat" = builtins.fetchGit {
      url = "https://github.com/ucb-bar/berkeley-hardfloat.git";
      rev = "45f5ae171a1950389f1b239b46a9e0d16ae0a6f4";
    };
    # `riscv-linux` is a very large repository (~1.7 GB .git directory).  we
    # wrap it in `makeFixed` so that snapshots can be stored in the binary
    # cache, and users don't need to clone the entire thing to compute package
    # hashes.
    "riscv-linux" = makeFixed "riscv-linux-src"
      "0rg4k6l64zsrgl7rv0kb0i65rarzpby0mmd6wbi840131s6fkfpp"
      (fetchSsith "riscv-linux"
        "efef6d75d068a8977337931797ea38df003bdafc" { ref = "ssith"; });
    "riscv-pk" = fetchSsith "riscv-pk"
      "303ede776c897d26c4b91d9166dfac87932d3f9e" { ref = "ssith"; };
    #"riscv-tests" = fetchSsith "riscv-tests"
    #  "09d997dc65a2c8108912874548feaad41dadb157" { ref = "gfe"; };
    #"riscv-tests/env" = fetchSsith "riscv-test-env"
    #  "994ade1196e6b4e5351c9d297d8ceba2ad6527a7" { ref = "gfe"; };
  };
}
