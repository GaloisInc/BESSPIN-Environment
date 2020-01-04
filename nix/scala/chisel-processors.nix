{python, stdenv, jre, rocket-chip, firrtl}:
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
                mkdir -p $out/scripts
                cp -R /tmp/${genDirName} $out
                cp -R scripts $out
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
                ${firrtl}/bin/firrtl -i ${firrtlSrc}/${genDirName}/galois.system.${procName}TVFPGAConfig.fir -o $out/${targetDir}/galois.system.${procName}TVFPGAConfig.v -X verilog --infer-rw TestHarness --repl-seq-mem -c:TestHarness:-o:$out/${targetDir}/galois.system.${procName}TVFPGAConfig.conf  -td $out/${targetDir}/galois.system.${procName}TVFPGAConfig/ 
            '';
          };

    makeProcessor = procName:
          let
            psrc = galoisSystemSrc procName;
            pfirrtl = firrtlTransformSrc psrc procName;
            targetDir = "galois.system.${procName}TVFPGAConfig";
          in stdenv.mkDerivation {
            name = "chisel-processor-${procName}";
            src = psrc;
            patches = [ ./vlsi_mem.patch ];
            buildInputs = [ python pfirrtl ];
            buildPhase = ''
            python ${psrc}/scripts/vlsi_mem_gen ${pfirrtl}/${targetDir}/galois.system.${procName}TVFPGAConfig.conf > /tmp/galois.system.${procName}TVFPGAConfig.behav_srams.v 
            '';
            installPhase = ''
              mkdir $out
              cp -R /tmp/* $out
            '';
          };

    p1-src = galoisSystemSrc "P1";
    p2-src = galoisSystemSrc "P2";

in makeProcessor "P2"
