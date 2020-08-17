{ fetchurl }:

let timestamp = "20200101T030944Z";
    fetchDebian = pkg: sha256: fetchurl {
      url = "https://snapshot.debian.org/archive/debian-ports/${timestamp}/pool-riscv64/main/${pkg}";
      inherit sha256;
    };
in {
  readline = fetchDebian "r/readline/libreadline8_8.0-3_riscv64.deb"
    "1759qwrh619njj1f57kvbnh0p01r38329kk93ii6ayyajg6gn8rx";
  gdb = fetchDebian "g/gdb/gdb_8.3.1-1_riscv64.deb"
    "0c1ygd624d73hjh7v124gyc6w2qazczfiapvgrjgl06175qma2qw";
  strace = fetchDebian "s/strace/strace_4.21-1_riscv64.deb"
    "0clmarjyayyf582mlf9bfg34d5wrczacs93fsllnr4lvlmn10rps";
}
