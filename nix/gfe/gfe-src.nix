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
      "1s2k2afg6sbjxkvaldxrq0bw5i61lxhfby3jsr7vvw0gxc9g9adn"
      (fetchSsith "gfe" "master"
        "e1b3a1463e1ffe2ef2c020c8982f72ab80e2392c" {})
      "e1b3a1463e1ffe2ef2c020c8982f72ab80e2392c";
    "FreeRTOS-mirror" = fetchFromGitHub2 {
      "owner" = "GaloisInc";
      "repo" = "FreeRTOS-mirror";
      "rev" = "89b4eb1901a3d9167486e15367b4fa93858f8ae0";
      "sha256" = "0mb5dkqw58n9b6fh0smqdrb15haphxipzmy9xd2p4vsd8cphnvsm";
      inherit context;
    };
    #"benchmarks/coremark" = fetchFromGitHub2 {
    #  "owner" = "GaloisInc";
    #  "repo" = "coremark";
    #  "rev" = "dd814bc221d7deae8b18ea8a68f0ec16b1b822d6";
    #  "sha256" = "05d1vzr1d7n0772axj0r8lqbbbfpfsal9jyb1r9dlvk92w3c1kzd";
    #  inherit context;
    #};
    "bluespec-processors/P1/Piccolo" = fetchBluespec "Piccolo"
      "551017672a551a30aec316821066f4481cd600e9" {};
    "bluespec-processors/P2/Flute" = fetchBluespec "Flute"
      "3a46d92ef6579f97ddf3d513661144ea44d52e2e" {};
    "bluespec-processors/P3/Tuba" = fetchBluespec "Tuba"
      "d337f1b8cf9c57c43239d25a180119a249591afc" {};
    "busybox" = togglePackagePerf "busybox"
      "1m8gkay00wy7sdm7hdwyfmss9903s04bhy44xjyczyj0mn24jhwp"
      (fetchGit2 {
        url = "https://git.busybox.net/busybox/";
        rev = "1dd2685dcc735496d7adde87ac60b9434ed4a04c";
        ref = "1_30_stable";
        inherit context;
      })
      "1dd2685dcc735496d7adde87ac60b9434ed4a04c";
    "chisel_processors" = fetchSsith "chisel_processors" "master"
      "b6562ea381e0ed556893e0b4f05407a3d0fe104d" {};
    "chisel_processors/chipyard" = fetchSsith "chipyard" "gfe"
      "242f63ac9f5d0ebec7cee30ff94d7017b5471886" {};
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
    "freebsd/cheribsd" = fetchFromGitHub2 {
      owner = "CTSRD-CHERI";
      repo = "cheribsd";
      rev = "1c93c7bd7e9039fbba054cabc043d4cbb80e717e";
      sha256 = "0hchjgaixc8751pfypk044cx4023cnkz0mn7bvb9cgcyq0vgxjr6";
      inherit context;
    };
    # `riscv-linux` is a very large repository (~1.7 GB .git directory).  we
    # wrap it in `makeFixed` so that snapshots can be stored in the binary
    # cache, and users don't need to clone the entire thing to compute package
    # hashes.
    "riscv-linux" = togglePackagePerf "riscv-linux"
      "17ynclsg0r31jsl4rb26fybngg5hsc04is9rbafs5yyg2l9560a9"
      (fetchSsith "riscv-linux" "ssith"
        "333e6ab0dd399fe5f668ac038a2cebd7be3e25b3" {})
      "333e6ab0dd399fe5f668ac038a2cebd7be3e25b3";
    #"riscv-openocd" = fetchSsith "riscv-pk"
    #  "27c0fd7a7504087e6d8b6158a149b531bda9260d" {};
    "riscv-pk" = fetchFromGitHub2 {
      owner = "riscv";
      repo = "riscv-pk";
      rev = "5d9ed238e1cabfbca3c47f50d32894ce94bfc304";
      sha256 = "18brv0dm56xi2q827aip8a07vds7mcj086l0kn8c7xj68d31ji2d";
      inherit context;
    };
    "riscv-tests" = fetchSsith "riscv-tests" "gfe"
      "1a4687f87655d761b7c5dfc736454d5507e69519" {};
    "riscv-tests/env" = fetchSsith "riscv-test-env" "gfe"
      "994ade1196e6b4e5351c9d297d8ceba2ad6527a7" {};
  };
}
