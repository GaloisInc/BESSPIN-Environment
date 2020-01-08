{ python, stdenv, jre
, lib, boom
, rocket-chip, firrtl
, procName ? "P1" }:

let

  genDirName = "generated-src";
  
  chiselConfig =  if ( procName == "P1" || procName == "P2" )
                  then "${procName}TVFPGAConfig"
                  else "Boom${procName}FPGAConfig";
                  
  sysName     = if ( procName == "P1" || procName == "P2" )
                  then "galois.system"
                  else "boom.galois.system";

  targetName = if ( procName == "P1" || procName == "P2" )
              then "${sysName}.${chiselConfig}"
              else "${sysName}.TestHarness.${chiselConfig}";
             
  rocketChipBase = if ( procName == "P1" || procName == "P2" )
                  then rocket-chip 
                  else boom; 
                  
  # create the FIRRTL source files                
  galoisSystemSrc = 
    rocketChipBase.overrideAttrs(old: {
      name = "galois-system-${procName}-firrtl-src"; 

      buildPhase =''
        mkdir -p build/${genDirName}
        sbt -v "runMain ${sysName}.Generator build/${genDirName} ${sysName} TestHarness ${sysName}  ${chiselConfig}"             
      '';
      
      installPhase = ''
        mkdir -p $out/${genDirName}
        cp -R build/${genDirName} $out
      '' + lib.optionalString (  procName == "P1" || procName == "P2" ) 
      ''
        mkdir -p $out/scripts
        cp -R scripts $out
      '';

      # the rocket chip needs more space than default JVM
      JAVA_OPTS="
        -Xmx4G
        -Xss8M
        -XX:MaxPermSize=256M
      ";
    });

    # create FIRRTL transformation files
    firrtlTransformSrc = 
        stdenv.mkDerivation {
            name = "galois-system-${procName}-firrtl";
            src = galoisSystemSrc;
            buildInputs = [ jre ];
            installPhase = ''
                mkdir -p $out/${targetName}
                ${firrtl}/bin/firrtl -i $src/${genDirName}/${targetName}.fir -o $out/${targetName}.v -X verilog --infer-rw TestHarness --repl-seq-mem -c:TestHarness:-o:$out/${targetName}.conf -td $out/${targetName}/
            '';
        };

in stdenv.mkDerivation ({
  name = "chisel-processor-${procName}";
  src = galoisSystemSrc;
    installPhase = ''
      mkdir $out
      cp ${genDirName}/* $out/
    '' + lib.optionalString (procName == "P1" || procName == "P2")
    ''
      cp -R build/* $out
    '';
  } // lib.optionalAttrs (procName == "P1" || procName == "P2") 
  {
    buildInputs = [ python ];
    buildPhase = ''
    mkdir build
    python $src/scripts/vlsi_mem_gen ${firrtlTransformSrc}/${targetName}.conf > build/${targetName}.behav_srams.v 
    '';
  }) 

