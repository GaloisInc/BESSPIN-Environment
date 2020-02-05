{ fetchurl }:
{ 
 image =  builtins.fetchurl{
    url = "https://artifactory.galois.com:443/besspin_generic-nix/FreeBSDQemu.elf";
    sha256 = "57a89a4f92a18013a3cff6185f368dadf54e99fe1adf3d0a44671f1e16ddca88";
  };
}
