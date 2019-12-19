# Updating `bin-deps.nix`

(1) Clear your Ivy cache, clean your git checkout, and run an ordinary `sbt
compile`, logging the output.

(2) Look for lines of the form `[info] downloading <url> ...`, and collect all
the URLs they list into a new file `jar-urls/<package>.txt`.  These are all the
JAR files used by the new package.

(3) Regenerate `bin-deps.nix` with the additional URLs:

    mkdir cache
    ls jar-urls/* | python3 gen-bin-deps.py > bin-deps.nix

(4) Try building your new package.  If you're lucky, it may build successfully
at this point, in which case, you're done.

Otherwise, the package may need metadata files for unused but related packages.
Look for lines like this in the `sbt` output:

    [warn] ==== local-maven: tried
    [warn]   file:/nix/store/<hash>-scala-repo/maven/org/sonatype/oss/oss-parent/6/oss-parent-6.pom
    [warn] ==== local-ivy: tried
    [warn]   /nix/store/<hash>-scala-repo/ivy2/org.sonatype.oss/oss-parent/6/ivys/ivy.xml

It's common to see "parent" in the names of missing packages, but this is not
guaranteed.

(5) Add the URLs of the missing `.pom` / `ivy.xml` files to a new URL list,
`jar-urls/<package>-meta.txt`.  The URL normally looks like

    https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/6/oss-parent-6.pom

for Maven packages, which are most common.  If the Maven version doesn't work
(meaning `gen-bin-deps.py` gets a 404 when downloading the file), then try
looking for a related package in the existing `bin-deps.nix` and basing the new
URL on its `metaUrl`.

Note, if you parse out the URLs using `grep`/`sed`, you should deduplicate them
at the end, since multiple packages may need the same metadata file at once.

(6) Repeat from step 3.  It may take several iterations to get all the missing
metadata files, but as long as there are different URLs each time in step 5,
you are making progress.


# Missing dependencies

Missing dependency errors are most commonly caused by `gen-bin-deps.py` setting
the wrong output path for the JAR file.  In other words, the JAR is in the
`binRepo`, but not in the place `sbt` expects.  Compare the paths shown in the
`sbt` output with the `jarDest`/`metaDest` paths in `bin-deps.nix`, and try to
figure out what rule `sbt` is using when looking for JARs so you can update the
Python script.
