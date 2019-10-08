{ stdenv, lib, fetchurl }:

let
  # XXX When bumping the repo snapshot timestamp, you must manually download
  # `${baseUrl}/dists/sid/InRelease` and check that it does not contain a
  # `Valid-Until` line.  If it does contain such a line, you'll need to figure
  # out how to make the the Debian image build process ignore Valid-Until.
  # Otherwise, Debian image builds will mysteriously start failing a week after
  # you change the timestamp!
  snapshotTimestamp = "20190915T062333Z";

  baseUrl = "http://snapshot.debian.org/archive/debian-ports/${snapshotTimestamp}";

  # When changing the timestamp, you must also regenerate the list of files
  # (and their hashes) in the repository.
  #  1. Edit scripts/debian-archive-proxy.py to use the new snapshotTimestamp
  #     in its repo url.
  #  2. Run scripts/debian-archive-proxy.py.
  #  3. In the GFE repo, manually peform a Debian image build, with the
  #     environment variable GFE_DEBIAN_URL=http://localhost:3142.  This will run
  #     the build using the proxy, allowing the proxy to generate the list of
  #     files accessed (debian-urls.txt).  Afterward, you can kill the proxy.
  #  4. Run:
  #         scripts/make-debian-repo-files.sh ${baseUrl} debian-urls.txt \
  #           >nix/misc/debian-repo-files.nix
  files = import ./debian-repo-files.nix;

  installCmd = file: let
    src = fetchurl {
      inherit (file) name url sha256;
    };
  in ''
    mkdir -p "$out/$(dirname "${file.relPath}")"
    cp ${src} "$out/${file.relPath}"
  '';

in stdenv.mkDerivation rec {
  name = "debian-repo-snapshot";
  version = snapshotTimestamp;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir $out

    ${lib.concatMapStringsSep "\n" installCmd files}
  '';
}
