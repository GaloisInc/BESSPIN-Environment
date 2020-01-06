{ python, stdenv, jre
, lib, gfeSrc, boom
, rocket-chip, firrtl
, procName ? "P1" }:
let 
  genDirName = "generated-src";
  galoisSystemSrc = procName:
    let
      # processor specific variables - P3 differs from P1, P2
      sysName     = if (procName == "P1" || procName == "P2")
                    then "galois.system"
                    else "boom.galois.system";
      chiselConfig =  if (procName == "P1" || procName == "P2")
                      then "${procName}TVFPGAConfig"
                      else "Boom${procName}FPGAConfig";
      name = "galois-system-${procName}-chisel-src"; 
      preBuild = ''
        mkdir -p /tmp/${genDirName}
      '';
      buildPhase =''
        runHook preBuild
        sbt -v "runMain ${sysName}.Generator  /tmp/${genDirName} ${sysName} TestHarness ${sysName}  ${chiselConfig}"             
        '';
      sbtBuildType = ''
        "runMain ${sysName}.Generator  /tmp/${genDirName} ${sysName} TestHarness ${sysName}  ${chiselConfig}"     
          '';
    in if (procName == "P1" || procName == "P2") then  
      rocket-chip.overrideAttrs(old: {
        inherit name buildPhase preBuild sbtBuildType;

        installPhase = ''
          mkdir -p $out/${genDirName}
          mkdir -p $out/scripts
          cp -R /tmp/${genDirName} $out
          cp -R scripts $out
        '';
      }) 
    else boom.overrideAttrs (old: {
        inherit name buildPhase preBuild sbtBuildType;
        installPhase = ''
          mkdir -p $out/${genDirName}
          cp -R /tmp/${genDirName} $out
          '';
      });

    # create FIRRTL transformation files
    firrtlTransformSrc = procSrc: procName:
        let 
          targetName = if (procName == "P1" || procName == "P2") 
            then "galois.system.${procName}TVFPGAConfig"
            else "boom.galois.system.TestHarness.BoomP3FPGAConfig";
        in stdenv.mkDerivation {
            name = "galois-system-${procName}-firrtl-src";
            src = procSrc;
            buildInputs = [ jre ];
            installPhase = ''
                mkdir -p $out/${targetName}
                ${firrtl}/bin/firrtl -i ${procSrc}/${genDirName}/${targetName}.fir -o $out/${targetName}.v -X verilog --infer-rw TestHarness --repl-seq-mem -c:TestHarness:-o:$out/${targetName}.conf -td $out/${targetName}/
            '';
          };

    makeProcessor = procName:
          let
            psrc = galoisSystemSrc procName;
            pfirrtl = firrtlTransformSrc psrc procName;
            targetName = if (procName == "P1" || procName == "P2") 
              then "galois.system.${procName}TVFPGAConfig"
              else "boom.galois.system.TestHarness.BoomP3FPGAConfig";
            installPhase = ''
              mkdir $out
              cp ${genDirName}/* $out/
            '' + lib.optionalString (procName == "P1" || procName == "P2")
            ''
              cp -R /tmp/* $out
            '';
            name = "chisel-processor-${procName}";
            src = psrc;
          in if (procName == "P1" || procName == "P2")
          then stdenv.mkDerivation {
            inherit name src installPhase;
            patches = [ ./vlsi_mem.patch ];
            buildInputs = [ python pfirrtl ];
            buildPhase = ''
            python ${psrc}/scripts/vlsi_mem_gen ${pfirrtl}/${targetName}.conf > /tmp/${targetName}.behav_srams.v 
            '';
          } 
          else stdenv.mkDerivation {
            inherit name src installPhase;
          };
     
in makeProcessor procName  
