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
      "10m2ijsdc86x15sqjig4ilnzbkvnypbsii55h31pnh8848prcmlb"
      (fetchSsith "gfe" "master"
        "e6316fe95a3cb52699d28439182727df5d6609bf" {})
      "e6316fe95a3cb52699d28439182727df5d6609bf";
    "FreeRTOS-mirror" = fetchFromGitHub2 {
      "owner" = "GaloisInc";
      "repo" = "FreeRTOS-mirror";
      "rev" = "5a9ac58e893cb3d9e60c2fa96fdc64966507f837";
      "sha256" = "07rs9an3dwad9cbrzyj1d6a9d1s6z6bq6z62gjxwmwkyikxbnl2y";
      inherit context;
    };
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
      "3944fb4fd8c62761e7ddb97bdf11ec756d68fc40" {};
    "chisel_processors/chipyard" = fetchSsith "chipyard" "gfe"
      "c2efd099afafa35a4034df54269f814ff942d0de" {};
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
      "1wrf3709xx8j323801mwg43cch7wgq3wn2vx59vj2m6gx0dfafc9"
      (fetchSsith "riscv-linux" "xdma"
        "01cd5605f1242d1a776fe98b82a39463d46f4dcd" {})
      "01cd5605f1242d1a776fe98b82a39463d46f4dcd";
    #"riscv-openocd" = fetchSsith "riscv-pk"
    #  "27c0fd7a7504087e6d8b6158a149b531bda9260d" {};
    "riscv-pk" = fetchSsith "riscv-pk" "ssith"
      "b2264c2b2c34b59052ff2357dc14023f4ce912d5" {};
    "riscv-tests" = fetchSsith "riscv-tests" "gfe"
      "1a4687f87655d761b7c5dfc736454d5507e69519" {};
    "riscv-tests/env" = fetchSsith "riscv-test-env" "gfe"
      "994ade1196e6b4e5351c9d297d8ceba2ad6527a7" {};
  };
}
