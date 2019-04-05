{ mkRacketDerivation }:

mkRacketDerivation rec {
  pname = "parsack";
  # 0.4 is the latest, but `toml` requires 0.3
  version = "0.3";
  src = builtins.fetchGit {
    url = "https://github.com/stchang/parsack.git";
    rev = "148957939b082ad88a6a12db48a35c352cfeddb6";
  };
}
