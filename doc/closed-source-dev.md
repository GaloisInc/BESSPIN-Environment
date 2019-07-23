This document describes how to work with the closed-source packages in this
repository.


# The trouble with `fetchGit`

We use `builtins.fetchGit` pervasively for fetching code from the SSITH
repositories, which are all private.  `fetchGit` clones a repository at
evaluation time, using the credentials of the user who invoked `nix-shell`.
This is unlike the `fetchgit` function (note the lowercase `g`) provided by
nixpkgs, which clones a repository at build time, using the credentials of the
Nix build user (which are usually empty).

The problem with `fetchGit` is that the hash of the source package produced by
`fetchGit` is derived from the result of the clone.  If the clone fails (for
example, because the calling user doesn't have permission to access a particular
repository), then the hash cannot be determined, and neither can the hashes of
any downstream packages.  This means the user must have access to all source
repositories accessed via `fetchGit` to even obtain pre-compiled packages from a
binary cache.

For most packages, we give all TA-1 teams access to the source repositories, so
running `nix-shell` can clone the repos, compute the hashes, and download the
binaries.  But for some packages, we cannot distribute source code.  In these
cases, we conditionally (based on the value of `haveSrc`, described below) set
the `src` attribute to either a `fetchGit` call or a call to `dummyPackage`,
which reports an error when attempting to build.

Changing `src` would normally change the hash of the package, which we must
prevent; otherwise, the package built from `fetchGit` source would have a
different hash than the `dummyPackage`-based variant, and we would be unable to
publish matching binaries to the binary cache.  For this, we use the `makeFixed`
function to give the `src` package a fixed output hash, regardless of whether
the `fetchGit` or `dummyPackage` variant is selected.  The fixed output hash
lets Nix compute the hashes of downstream packages and find appropriate binaries
in the binary cache, even when it's unable to access the repo referenced by
`fetchGit`.

In the future, we may want to wrap more `fetchGit` calls in `makeFixed`, even if
it's not strictly necessary, as a way to reduce the size of the initial tool
suite download.


# `haveSrc`

The `haveSrc` argument can be used to tell the Nix packaging infrastructure that
you have access to the source code for a particular closed-source package.  For
example, you can invoke `nix-shell` like this to indicate that you have access
to the ssith/verific> repository:

    nix-shell --arg haveSrc '{ verific = true; }'

The [`verific.nix`](../nix/cxx/verific.nix) package checks the value of
`haveSrc.verific` to determine whether it should try to download and build the
Verific source code.  Setting this flag is necessary if you're working on the
Verific package itself or on a package that depends on it.

Once a particular revision of the source code has been downloaded, it will
remain in your Nix store, so there's no need to pass `--arg haveSrc ...` on
subsequent runs of `nix-shell` unless you change the git revision used to build
the package.


# `makeFixed`

The function `makeFixed` converts an ordinary package into a fixed-output
package.  Nix can compute the store-path hash of such a package from only the
provided hash of its outputs, without looking at any other parts of the
definition of the package.  When Nix builds a fixed-output package, it checks
that the build outputs actually match the provided hash.

We use `makeFixed` to wrap `haveSrc` checks, like this:

    src = makeFixed "verific-source-private" "17h5b7ln..."
      (if haveSrc.verific or false then fetchGit { /*...*/ }
      else dummyPackage "verific");

When `haveSrc.verific` is set, the output of the `src` package is the output of
`fetchGit`, and the hash of that output is checked against `17h5b7ln...`.  When
the flag is unset, Nix tries to build `dummyPackage "verific"`, which fails with
an error message (and, notably, does not require access to the private
ssith/verific> repo).

A common pitfall when working with fixed-output packages is to change parts of
the package definition (in this case, the arguments to `fetchGit`) without
updating the hash.  If a fixed-output package with the old hash exists in
`/nix/store`, Nix will happily use its contents, ignoring all changes to the
package definition.  The recommended workflow for updating closed-source
packages is as follows:

 1. Temporarily remove the `makeFixed` wrapper, leaving only `src = (if haveSrc
    ...)`.  Note that this changes the hash of the enclosing package, so it
    can't be usefully published to the binary cache.
 2. Adjust `fetchGit` arguments as needed (for example, bumping `rev` to the
    most recent release).
 3. Once the package builds successfully, compute the hash of the final `src`.
    Find the path of the source package in the package's build logs, and run
    `nix hash-path --type sha256 --base32 /nix/store/aabbccdd...-source`.
 4. Restore the `makeFixed` wrapper, using the computed hash.  This restores the
    package to a publishable state.

(Or, the quick-and-dirty way: make the output hash invalid, such as by replacing
part of it with `00000`, and adjust the `fetchGit` arguments as desired.  Then
try to build the package.  It will fail, but the error message will include the
correct hash, which you can paste back into the package definition.  The
downside is that this process becomes annoying if you have to make multiple
adjustments to `fetchGit` to get the package working.)
