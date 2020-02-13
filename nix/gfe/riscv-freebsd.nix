{ fetchurl }:
{
  imageQemu = fetchurl {
    url = "http://localhost:8000/FreeBSDQemu.elf";
    sha256 = "57a89a4f92a18013a3cff6185f368dadf54e99fe1adf3d0a44671f1e16ddca88";
  };

  imageFpga = fetchurl {
    url = "http://localhost:8000/FreeBSD.elf";
    sha256 = "14izf7cqmgf62pysc7lv8fv9ma41g2nnr6fvrzbvfb627727ynwg";
  };
}
