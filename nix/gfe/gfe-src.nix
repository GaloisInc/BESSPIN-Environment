{ fetchGit2, fetchFromGitHub2, assembleSubmodules, togglePackagePerf
, context ? "" }:

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
  # Fetch a package from a gitlab-ext SSITH repo.  The `ref` (branch name) is
  # mandatory because otherwise we'd be relying on the target repo having a
  # specific default branch.
  fetchSsith = name: ref: rev: args: fetchGit2 ({
    name = "${name}-source";
    url = "git@gitlab-ext.galois.com:ssith/${name}.git";
    inherit rev ref context;
  } // args);

  fetchBluespec = name: rev: args: fetchGit2 ({
    name = "${name}-source";
    url = "https://github.com/bluespec/${name}.git";
    inherit rev context;
  } // args);

in assembleSubmodules {
  name = "gfe-source";
  # Many GFE submodules are omitted from this list, aside from the ones that
  # are currently commented out.  This avoids wasting space and download time
  # on large sources that aren't used for any packages at the moment.
  modules = {
    "." = togglePackagePerf "gfe"
      "17g61kr2fps02wambs84qbmbkz6vkvq1wl3zhgs3hhrs1pr1wvs4"
      (fetchSsith "gfe" "master"
        "f9e364d04420af762a531ff53ee8837d16a34131" {});
    "FreeRTOS-mirror" = fetchFromGitHub2 {
      "owner" = "GaloisInc";
      "repo" = "FreeRTOS-mirror";
      "rev" = "d5f828cb446c3b18f70aecf1bdfac6106bbddc99";
      "sha256" = "0s10slgra8dp73dsc2vqpkb6chz155zjlwlznplcc0jk8lgzsvvm";
      inherit context;
    };
    "bluespec-processors/P1/Piccolo" = fetchBluespec "Piccolo"
      "c47d309f1db1fd0e95020e83803d4649f5d119a1" {};
    "bluespec-processors/P2/Flute" = fetchBluespec "Flute"
      "e4655e4241792ca7b88ace83f5265ecd0fcdcc6d" {};
    "bluespec-processors/P3/Tuba" = fetchBluespec "Tuba"
      "bb557e5e230c479359e95bc0d906bb3bec0ff669" {};
    "busybox" = togglePackagePerf "busybox"
      "1m8gkay00wy7sdm7hdwyfmss9903s04bhy44xjyczyj0mn24jhwp"
      (fetchGit2 {
        url = "https://git.busybox.net/busybox/";
        rev = "1dd2685dcc735496d7adde87ac60b9434ed4a04c";
        ref = "1_30_stable";
        inherit context;
      });
    "chisel_processors" = fetchSsith "chisel_processors" "master"
      "1a7df30fc26a4f1b9ff8d2fb223b789ae3ea39fb" {};
    "chisel_processors/P3/boom-template" = fetchSsith "boom-template" "ssith"
      "c93af5067727226e58c639ae8ffffe3bc8395ad0" {};
    "chisel_processors/P3/boom-template/boom" = fetchSsith "riscv-boom" "ssith-2.2.1"
      "539c22a878fe509fb8bd1370e737007b27bc3a28" {};
    "chisel_processors/P3/boom-template/rocket-chip" = fetchSsith "rocket-chip" "ssith-p3"
      "35c6fa4983efbe85fefb0f7259fc27b832bd9dd7" {};
    "chisel_processors/rocket-chip" = fetchSsith "rocket-chip" "ssith-p2-tv"
      "616ac6391579d60b3cf0a21c15a94ef6ccdd90a9" {};
    "chisel_processors/rocket-chip/chisel3" = fetchSsith "chisel3" "ssith-tv"
      "d17be75d919d65d9831d085bd4b5ea72e53156a6" {};
    "chisel_processors/rocket-chip/firrtl" = fetchGit2 {
      url = "https://github.com/ucb-bar/firrtl.git";
      rev = "860e6844708e4b87ced04bcef0eda7810cba106a";
    };
    "chisel_processors/rocket-chip/hardfloat" = fetchGit2 {
      url = "https://github.com/ucb-bar/berkeley-hardfloat.git";
      rev = "45f5ae171a1950389f1b239b46a9e0d16ae0a6f4";
      inherit context;
    };
    # `riscv-linux` is a very large repository (~1.7 GB .git directory).  we
    # wrap it in `makeFixed` so that snapshots can be stored in the binary
    # cache, and users don't need to clone the entire thing to compute package
    # hashes.
    "riscv-linux" = togglePackagePerf "riscv-linux"
      "07sqlkqjy36nj2a6455n4sx67wv70qbfs5w9kkc044261irs8imd"
      (fetchSsith "riscv-linux" "xdma"
        "0818fd8a6e61d49020db506d13a96d6c60ef95fd" {});
    #"riscv-openocd" = fetchSsith "riscv-pk"
    #  "27c0fd7a7504087e6d8b6158a149b531bda9260d" {};
    "riscv-pk" = fetchSsith "riscv-pk" "ssith"
      "303ede776c897d26c4b91d9166dfac87932d3f9e" {};
    "riscv-tests" = fetchSsith "riscv-tests" "gfe"
      "1a4687f87655d761b7c5dfc736454d5507e69519" {};
    "riscv-tests/env" = fetchSsith "riscv-test-env" "gfe"
      "994ade1196e6b4e5351c9d297d8ceba2ad6527a7" {};
  };
}
