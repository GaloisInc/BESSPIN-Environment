# Release process

## Update Git revisions

Make sure the revisions referenced in the various `.nix` files are the latest
revisions for release.  Check in with performers responsible for the various
sub-projects (`testgen`, `arch-extract`, etc.) to find out which subproject
revisions should be used.

To update the revision for a project, find where the sources for that project
are declared, and update the `rev` argument to `fetchGit2` to point to the new
revision.  Typically each repository is declared in only one `.nix` file; if
multiple packages are built from the same sources, then the sources are
declared in their own file (such as `nix/gfe/gfe-src.nix`) and that file is
referenced everywhere the sources are needed.

**Submodules**: When updating a repo with submodules, you must manually update
all submodule revisions as well.  These repos use the `assembleSubmodules` Nix
function, and list all submodule repositories and revisions explicitly.  To
update the submodules to match the new revision of the top-level repo, clone
the repo, check out the new revision, update the submodules (for GFE,
`./init_submodules.sh`; otherwise, `git submodule update --init`), and run `git
submodule status` to see the submodule revisions in use.  Then make sure the
submodule revisions used in the arguments of `assembleSubmodules` match the
ones reported by `git`.  You may also need to adjust or add new `ref` arguments
if the submodule commit is on a non-default branch.

**Branches**: `fetchGit2` does not clone the target `rev` directly, because
some Git servers don't support this.  Instead, it clones a branch or tag,
indicated by its `ref` argument, and then searches for `rev` in the history of
that branch/tag.  When updating a `rev` to point to a commit that's not on the
default (`HEAD`) branch of its repository, you must update `ref` as well so
that `fetchGit2` can find the commit.

**Fixed-output source packages**: Some sources packages are fixed-output,
either because they are defined using `fetchFromGitHub2` or because they are
wrapped in `togglePackagePrivate`/`togglePackagePerf`.  They can be identified
by the base32 SHA256 hash argument passed to the function.  When updating the
Git `rev`, you must also update the `sha256` hash argument to the hash of the
new source contents.  **Don't forget to do this** - if you forget, Nix will
believe the old and new sources are identical, and will continue using the old
ones without telling you.  The correct way to update the hash is to run
`nix-prefetch-url` or `nix-prefetch-git`; the easy way is to invalidate the
hash (replace part of it with `xxxxx`), run the build until you get a hash
mismatch error, and copy the correct hash from the error message back into the
`.nix` file.

## Build the updated packages

An ordinary run of `nix-shell` should be enough to trigger the build.

**Toggled packages**: If you've modified any package that's wrapped in
`togglePackagePrivate` or `togglePackagePerf`, you'll need to enable building
of those packages in your `config.nix`, by setting `buildPrivate.<name>` or
`fetchUncached.<name>` to `true`.  If you don't do this, trying to build will
produce an error message, which will tell you the exact setting you need to
change.

## Deploy packages to the binary cache

We have a Python script to sign and deploy packages to the BESSPIN binary
cache.  This script can be run inside a Nix shell to deploy binary builds of
the packages used in that shell.

The basic invocation is:

    python3 scripts/deploy/nix_http.py \
        --no-skip-fixed-output \
        $stdenv $buildInputs $extraInputs $cachePackages

The four environment variables are set by the current Nix shell to contain
lists of relevant packages.

The script requires access to your Artifactory username and API key, as well as
the private key we use to sign binary cache packages.  See the `--help` output
for the `--user`, `--password-file`, and `--nix-private-key-file` options.

Another useful option is `--dry-run` (shows you what it would sign and upload,
but doesn't actually do anything).

If a deployment fails partway through, the script can get confused about which
packages have been deployed.  (Normally it assumes anything that's been signed
has also been deployed, but if an upload fails after signing, that might not be
the case.)  After a failed deploy, run with `--check-signed-by-self` to make
the script scan the binary cache for missing packages.

**cache-essential**: There is a subset of packages that must always be kept
up-to-date on the binary cache, even between releases.  These are listed in the
`nix/dev/cache-essential.nix` file.  Any time you update one of these packages,
you should deploy new copies of all the `cache-essential` packages **before you
push the new `.nix` files to GitLab**.  If you don't do this, anyone who checks
out the updated `.nix` files will have trouble running the normal nix-shell.
To update the `cache-essential` packages, run `nix-shell
nix/dev/cache-essential.nix`, and run the normal deploy command in the
resulting shell.  It's also good to double-check that the `cache-essential`
packages are up-to-date at release time, though usually this is a no-op.

## Test the new release

Set up a fresh Debian VM, install Nix, and check that you can get into the Nix
shell.

Using a fresh VM lets you detect some errors that could be hidden by caching on
your local machine:

 1. If you provide `fetchGit2` with a `ref` that doesn't contain the target
    `rev` in its history, but the commit happened to be fetched by some other
    `fetchGit2` invocation, then Nix will retrieve the `rev` from its cache and
    won't check that it's an ancestor of the `ref`.  With an empty cache, Nix
    will error out (as it would on a user's machine).

    Note the cache in question here is `~/.cache/nix/git` /
    `~/.cache/nix/gitv2`, not the main Nix store.

 2. If some packages failed to deploy to the binary cache, Nix will try to
    build them when run on the VM, allowing you to spot the problem.  If
    everything was deployed properly, Nix should build very few packages
    (ideally, none at all), and certainly nothing that takes a long time to
    build.

For testing, make sure everything in the tutorial works correctly.  Some steps
may require running on an FPGA machine instead of the VM.

If anything requires fixing, don't forget to deploy the fixed packages to the
binary cache before re-testing.  There's no need to remove the old packages
from the binary cache - someday we'll probably need to run garbage collection
on it, but the whole cache is still well under 10 GB for now.

