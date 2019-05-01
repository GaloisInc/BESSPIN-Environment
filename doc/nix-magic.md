This documentation is aimed at tool suite developers, not end users.


# Weird Nix magic

This file describes some of the more obscure features of Nix, since information
on these is often omitted from online Nix tutorials.


## The Nixpkgs manual

There are *two* manuals you'll need to work on Nix packages.  The first one is
the Nix manual:

https://nixos.org/nix/manual/

This includes useful stuff like the syntax and semantics of the Nix expression
language, and docs for most (unfortunately not all) of the language builtins.

The other one is the Nixpkgs manual:

https://nixos.org/nixpkgs/manual/

This documents the parts of the Nixpkgs package repository that are useful for
developing future packages.  Individual application or library packages don't
usually merit a section in the manual - instead, it documents things like the
overall Haskell build infrastructure (and its various options for defining and
modifying Haskell packages), the generic package-override functionality, or the
`stdenv` library that's the basis of most other Nix packages.


## Setup hooks

The "setup hooks" feature allows packages to register arbitrary shell scripts
to be run before the main builder/shell any time the package appears in
`buildInputs`.  This feature is described by the Nixpkgs manual as "a bit of a
sledgehammer", "anti-modular", and "a last resort", but is nonetheless used
pervasively.

As an example, the `cmake` package registers a setup hook that modifies the
default behavior of the `configurePhase` to invoke `cmake` instead of
`./configure`.  So any package that lists `cmake` as a dependency in its
`buildInputs` will be configured with `cmake` by default, instead of the normal
autotools-style configuration.

Some setup hooks involve scanning the other `buildInputs` for some purpose.
For example, `python`'s setup hook looks for Python library directories.  So
when `python` is present in `buildInputs`, its setup hook will scan the other
`buildInputs` and add any Python library directories it finds to `$PYTHONPATH`.

Some (but not all) setup hooks are document in the Nixpkgs manual:
https://nixos.org/nixpkgs/manual/#ssec-setup-hooks


## Linking

In a typical Linux distro, an executable lists the shared libraries that it
requires, and the dynamic linker (`ld.so`) finds those libraries by searching a
few built-in paths, such as `/lib` and `/usr/lib`.  In Nix, there is no single
"library directory", so a different strategy is needed: each executable, in
addition to the list of required libraries, also includes a list of directories
where the linker should search for those libraries (called the "rpath" or
"RUNPATH").

For Nix-built binaries, this is all handled automatically.  The Nix build
environment (`stdenv`) provides wrappers around the default compiler and
linker that make sure the rpath is set appropriately, based on the libraries
requested and the `buildInputs` of the package being built.

However, problems arise when trying to use binaries compiled for "normal" Linux
within Nix.  These binaries normally don't provide a RUNPATH, so the Nix
dynamic linker can't find the shared libraries they require.

Nix provides a workaround in the form of `patchelf`, which can rewrite a
compiled binary to set its rpath (among other things).  For a more convenient
approach, add `autoPatchelfHook` to the package's `buildInputs`.  This provides
an `autoPatchelfFile` shell function to fix the rpath of a binary.  For any
required library that isn't found using the (very limited) default search
paths, it scans the `buildInputs` to find one that contains the library, and
adds the `lib` subdirectory of that package to the binary's new rpath.


## Package scopes

The `callPackage` function scans the arguments of the called package, filling
them in automatically with packages of the same name.  But it can only provide
packages that it "knows about" - that is, packages in its scope.  The "default"
`callPackages` is tied to the top-level package set, defined in
`$nixpkgs/pkgs/top-level/all-packages.nix`, but other `callPackage`s can
exist and can be tied to different package scopes.  This is commonly used for
language-specific build infrastructure, since it's convenient to be able to
obtain other language packages directly.

For an example, see the definition of `haskellEnv` in `nix/besspin-pkgs.nix`,
which uses a Haskell-specific `callPackage` (`self.callPackage`) that knows
about all the Haskell packages defined in `nixpkgs`.  This means
`nix/haskell/clafer-0.5.0.nix` can simply request `mtl` in its argument list,
even though `mtl` is not known to the top-level `callPackage`.

Unfortunately, the set of packages that can be referenced in a `.nix` file's
argument list is determined entirely by the *caller* of that file.  This is one
reason for dividing up packages by source language.  All files in
`nix/haskell/*.nix` expect to be called using the Haskell-specific
`callPackage` (with Haskell packages in scope), while the ones in `nix/racket/`
require the Racket-specific `callPackage` instead.

Package scopes form a sort of hierarchy, in that newly-defined package scopes
inherit all the packages of some "parent" scope.  So, for example,
`nix/racket/rosette.nix` can refer to the top-level `z3` package, because the
Racket `callPackage` inherits `z3` from the top-level `callPackage`.


### Defining new scopes

Each package scope is in fact recursive, defined using a fixpoint operator.
This means all packages defined in the scope can use the scope's `callPackage`,
while simultaneously `callPackage` has access to all packages in the scope.
This is useful because it lets any package refer to any other package,
regardless the order of their definitions within the enclosing package set.
(However, this also makes it possible to define packages with circular
dependencies, which will cause an exception during evaluation.)

For an example of this, see `nix/racket/racket-env.nix`, which defines its own
Racket-specific `callPackage`, tied to a new recursive package scope.  This new
`callPackage` lets the packages in `nix/racket/*.nix` import each other
directly, without needing to use qualified names such as `racketEnv.foo` for
most of their dependencies.


## `pkgs.path`

The Nixpkgs collection exposes an attribute called `path`, which contains the
collection's own path in the Nix store.  For convenience, the tool suite's
`shell.nix` exposes this as an environment variable `$nixpkgs`.  This provides
an easy way to find the exact Nixpkgs revision that the tool suite uses, since
it's often useful to grep through the entirety of Nixpkgs to find a package or
library function of interest.
