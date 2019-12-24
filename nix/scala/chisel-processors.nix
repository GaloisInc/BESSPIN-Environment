{stdenv, jre, rocket-chip, firrtl}:
let 
    genDirName = "generated-src";

    # generate files from chisel3 project
    galoisSystemSrc = procName:
        rocket-chip.overrideAttrs(old: {
            name = "galois-system-${procName}-chisel-src"; 
            preBuild = '' mkdir -p /tmp/${genDirName} '';
            buildPhase =''
                mkdir -p /tmp/${genDirName}
                sbt -v "runMain galois.system.Generator /tmp/${genDirName} galois.system TestHarness galois.system ${procName}TVFPGAConfig"             
            '';
            sbtBuildType = ''
                "runMain galois.system.Generator /tmp/${genDirName} galois.system TestHarness galois.system ${procName}TVFPGAConfig"
            '';
            installPhase = ''
                mkdir -p $out/${genDirName}
                cp -R /tmp/${genDirName} $out
            '';
        });

    # create FIRRTL transformation files
    firrtlTransformSrc = firrtlSrc: procName:
        let 
            targetDir = "galois.system.${procName}TVFPGAConfig";
        in stdenv.mkDerivation {
            name = "galois-system-${procName}-firrtl-src";
            src = firrtlSrc;
            buildInputs = [ jre ];
            installPhase = ''
                mkdir -p $out/${targetDir}
                ${firrtl}/bin/firrtl -i ${firrtlSrc}/${genDirName}/galois.system.${procName}TVFPGAConfig.fir -o galois.system.${procName}TVFPGAConfig.v -X verilog --infer-rw TestHarness  --repl-seq-mem -c:TestHarness:-o:$out/${targetDir}/galois.system.${procName}TVFPGAConfig.conf -faf ${firrtlSrc}/${genDirName}/galois.system.${procName}TVFPGAConfig.anno.json -td $out/${targetDir}
            '';
        };
in {
    p1-src = galoisSystemSrc "P1";
    p2-src = galoisSystemSrc "P2";
    p1-firrtl = firrtlTransformSrc p1-src "P1";
    p2-firrtl = firrtlTransformSrc p1-src "P2";
}