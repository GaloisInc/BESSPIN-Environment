{rocket-chip, firrtl}:
let 
    galoisSystemSrc = generatedDir: procName:
        rocket-chip.overrideAttrs(old: {
            name = "galois-system-${procName}-src";
            preBuild = '' mkdir -p /tmp/${generatedDir} '';
            buildPhase =''
                sbt -v "runMain galois.system.Generator /tmp/${generatedDir} galois.system TestHarness galois.system ${procName}TVFPGAConfig"             
            '';
            installPhase = ''
                mkdir -p $out/${generatedDir}
                cp -R /tmp/${generatedDir} $out
            '';
            scalaDeps = old.scalaDeps ++ [ firrtl ];
        });
in (galoisSystemSrc "generated-src" "P1")