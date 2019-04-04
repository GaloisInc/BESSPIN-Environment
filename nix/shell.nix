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

  haskellEnv = haskell.packages.ghc844.override {
    overrides = self: super: {
      # Clafer dependencies.  The default versions from nixpkgs don't build
      # successfully on this GHC version.
      data-stringmap = self.callPackage haskell/data-stringmap-1.0.1.1.nix {};
      json-builder = self.callPackage haskell/json-builder-0.3-for-ghc84.nix {};
      clafer_0_4_5 = self.callPackage haskell/clafer-0.4.5.nix {};
    };
  };


  configurator = callPackage besspin/configurator.nix {};
  configuratorWrapper = binWrapper besspin/besspin-configurator {
    inherit bash;
    python3 = pythonEnv.withPackages (ps: with ps; [ flask ]);
    clafer = haskellEnv.clafer_0_4_5;
    inherit configurator;
  };

in mkShell {
  buildInputs = [
    (pythonEnv.withPackages (ps: with ps; [
      flask
    ]))

    (haskellEnv.clafer_0_4_5)

    configuratorWrapper
  ];

  nixpkgs = path;
}

