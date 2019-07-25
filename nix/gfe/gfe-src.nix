{ callPackage }:

let
  # TODO: get assembleSubmodules from besspin pkg scope
  assembleSubmodules = callPackage ../assemble-submodules.nix {};

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
      "bc6418b9bf2d28c3fdb10526ade2ab37ed3bad9b" { ref = "develop"; };
    #"FreeRTOS-mirror" = fetchSsith "FreeRTOS-mirror"
    #  "f38efd4f6dd4dd7d7179103a634b389fa41859d9" {};
    "bluespec-processors/P1/Piccolo" = fetchBluespec "Piccolo"
      "c47d309f1db1fd0e95020e83803d4649f5d119a1" {};
    "bluespec-processors/P2/Flute" = fetchBluespec "Flute"
      "c9dcf6a1ccf5b8a4b506e16a48395177e3d3bb32" { ref = "ssith"; };
    "bluespec-processors/P3/Tuba" = fetchBluespec "Tuba"
      "bb557e5e230c479359e95bc0d906bb3bec0ff669" {};
    #"busybox" = builtins.fetchGit {
    #  url = "https://git.busybox.net/busybox.git";
    #  rev = "1dd2685dcc735496d7adde87ac60b9434ed4a04c";
    #};
    "chisel_processors" = fetchSsith "chisel_processors"
      "1a7df30fc26a4f1b9ff8d2fb223b789ae3ea39fb" {};
    "chisel_processors/P3/boom-template" = fetchSsith "boom-template"
      "c93af5067727226e58c639ae8ffffe3bc8395ad0" { ref = "ssith"; };
    "chisel_processors/P3/boom-template/boom" = fetchSsith "riscv-boom"
      "539c22a878fe509fb8bd1370e737007b27bc3a28" {};
    "chisel_processors/P3/boom-template/rocket-chip" = fetchSsith "rocket-chip"
      "35c6fa4983efbe85fefb0f7259fc27b832bd9dd7" { ref = "ssith-p3"; };
    "chisel_processors/rocket-chip" = fetchSsith "rocket-chip"
      "616ac6391579d60b3cf0a21c15a94ef6ccdd90a9" { ref = "ssith-p1"; };
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
    #"riscv-linux" = fetchSsith "riscv-linux"
    #  "efef6d75d068a8977337931797ea38df003bdafc" {};
    #"riscv-pk" = fetchSsith "riscv-pk"
    #  "303ede776c897d26c4b91d9166dfac87932d3f9e" {};
    #"riscv-tests" = fetchSsith "riscv-tests"
    #  "09d997dc65a2c8108912874548feaad41dadb157" { ref = "gfe"; };
    #"riscv-tests/env" = fetchSsith "riscv-test-env"
    #  "994ade1196e6b4e5351c9d297d8ceba2ad6527a7" { ref = "gfe"; };
  };
}
