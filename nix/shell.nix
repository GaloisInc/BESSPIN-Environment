{ mkShell, callPackage, path
, bash, python37, haskell
}:

let

  binWrapper = callPackage ./bin-wrapper.nix {};

  # Customized Python 3.7 environment with BESSPIN dependencies installed.
  pythonEnv = (python37.override {
    packageOverrides = self: super: {
      # `hypothesis` test suite currently fails
      hypothesis = super.hypothesis.overridePythonAttrs (old: { doCheck = false; });
    };
  });
  python3 = pythonEnv;

  haskellEnv = haskell.packages.ghc844.override {
    overrides = self: super: {
      # Clafer dependencies.  The default versions from nixpkgs don't build
      # successfully on this GHC version.
      data-stringmap = self.callPackage haskell/data-stringmap-1.0.1.1.nix {};
      json-builder = self.callPackage haskell/json-builder-0.3-for-ghc84.nix {};
      clafer_0_4_5 = self.callPackage haskell/clafer-0.4.5.nix {};
    };
  };

  verific_2018_06 = callPackage cxx/verific.nix {
    version = "2018-06";
    rev = "71ecf0524b1084ac55368cd8881b864ec7092c69";
  };
  verific = callPackage cxx/verific.nix {};

  # Csmith, built from the galois `bof` branch.
  csmith-bof = callPackage cxx/csmith.nix {};


  configurator = callPackage besspin/configurator.nix {};
  configuratorWrapper = binWrapper besspin/besspin-configurator {
    inherit bash;
    python3 = pythonEnv.withPackages (ps: with ps; [ flask ]);
    clafer = haskellEnv.clafer_0_4_5;
    inherit configurator;
  };

  halcyon = callPackage besspin/halcyon.nix {
    # Halcyon uses the `PrettyPrintXML` function, which was removed after the
    # June 2018 release of Verific.
    verific = verific_2018_06;
  };

  bofgen = callPackage besspin/bofgen.nix { inherit csmith-bof; };
  bofgenWrapper = binWrapper besspin/besspin-bofgen { inherit bash python3 bofgen; };

in mkShell {
  buildInputs = [
    (pythonEnv.withPackages (ps: with ps; [
      flask
    ]))

    (haskellEnv.clafer_0_4_5)

    configuratorWrapper
    halcyon
    bofgenWrapper
  ];

  nixpkgs = path;
}

