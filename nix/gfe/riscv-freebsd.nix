{ fetchurl }:
{ 
 image =  fetchurl {
    url = "file:///temp-build/riscv.img";
    sha256 = "04hl8z9f07vmnwrlgd1n6g27v1lx443lwawdx04rw7xlcmlljrfy";
  };
  bbl = fetchurl {
    url = "file:///temp-build/bbl";
    sha256 = "1whc0r1iysgi718n9h4prn5vcwmfl07j7q8aldvsbznk7w84dfvk";
  };
}
