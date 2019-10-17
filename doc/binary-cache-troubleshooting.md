# Nix binary cache troubleshooting

If you have set up the binary cache but still get errors instructing you to set
it up, here are some steps to diagnose the problem.

**Alternate Nix configurations**: We recommend a multi-user/nix-daemon
installation using the [instructions from the Nix
manual](https://nixos.org/nix/manual/#sect-multi-user-installation).  These
troubleshooting instructions are designed for that configuration.  If you have
installed Nix in some other configuration, including in single-user mode, first
consult the section on [alternate Nix configurations](#single-user-nix), which
describes changes you may need to make to these troubleshooting steps to apply
them to your installation.

Begin troubleshooting by running `nix-shell --dry-run |& tee nix.log`, then
read the contents of `nix.log`.

 * If the log begins with the error message
   `https://artifactory.galois.com/besspin_generic-nix does not appear to be a
   binary cache`, then [Nix is unable to read from the binary
   cache](#permission-errors)

 * If it does *not* contain a section titled `these paths will be fetched`,
   then [Nix is not configured to use the binary cache](#configuration-errors)

 * If the log *does* contain a section titled `these paths will be fetched`,
   but running `nix-shell` normally still produces errors instructing you to
   set up the binary cache, then [Nix is trying to install packages that are
   not present on the binary cache](#missing-packages)

If you exhaust all troubleshooting steps and still have trouble, run this
command:

    nix-shell -j1 --run 'echo ok' |& tee nix.log

and [open an issue](https://gitlab-ext.galois.com/ssith/tool-suite/issues/new)
with the new `nix.log` file attached.

The remaining sections cover possible fixes for each type of error.


## Configuration errors

 *  Make sure the binary cache configuration is present in your
    `/etc/nix/nix.conf`.  The file should contain these two lines:

        trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= besspin.galois.com-1:8IqXQ2FM1J5CuPD+KN9KK4z6WHve4KF3d9zGRK+zsBw=
        substituters = https://artifactory.galois.com/besspin_generic-nix/ https://cache.nixos.org/

 *  Restart your Nix daemon:

        sudo systemctl restart nix-daemon.service

    This must be done after editing `nix.conf` to let the daemon pick up the
    new configuration settings.


## Permission errors

**Galois employees**: Permissions for accessing the binary cache are managed
differently for Galois BESSPIN team members than for TA-1 teams.  See the
section on [Galois-internal setup](#galois-internal-setup) for details.

 *  Make sure you have placed the appropriate credentials in `/etc/nix/netrc`.  
    The file should look like this:

        machine artifactory.galois.com
        login <your username>
        password <your key>

    Replace `<your username>` and `<your key>` with the binary cache
    credentials for your team.  These credentials were distributed by email at
    the time of Tool Suite Release 2.  Be sure to remove the double quotes
    around the key before pasting it into the `netrc` file.

 *  Check the permissions on `/etc/nix/netrc`.  The file should be owned by
    `root` and have `0600` permissions:

        sudo chmod 0600 /etc/nix/netrc

 *  Try downloading a file with `curl` using the credentials in the `netrc`
    file.  This will ensure that the credentials are valid for accessing the
    binary cache:

        sudo curl --netrc-file /etc/nix/netrc https://artifactory.galois.com/besspin_generic-nix/nix-cache-info

    This should print `StoreDir: /nix/store`.  If it reports an error instead
    (including a 404), there is a problem with the credentials in the `netrc`
    file.  Check that the API key on the `password` line is not missing any
    characters at the start or end.


## Missing packages

 *  Make sure you have not modified any tool-suite files.  Modifying package
    definitions changes their hash, meaning precompiled binaries can no longer
    be obtained from the binary cache.

 *  Check which branch of the tool-suite repository you are using.  If you are
    on `master`, and some packages are unavailable, this represents a bug in
    the binary cache deployment process - please open an issue so we can fix
    it.

 *  If you are on `develop`, and the error you receive when running `nix-shell`
    says that "uncached fetches are disabled for performance reasons", it's
    possible that the package in question was changed recently without being
    updated in the binary cache.  You can work around this by creating a file
    `~/.config/besspin/config.nix` containing:

        {
            fetchUncached.<package name> = true;
        }

    But please also open an issue for updating the binaries for the
    `cache-essential.nix` packages.


## Alternate Nix configurations

### Single-user installations

Single-user installations of Nix place their configuration files in different
locations.

 *  `nix.conf` is located at `~/.config/nix/nix.conf` instead of
    `/etc/nix/nix.conf`.

 *  `netrc` is located at `~/.config/nix/netrc` instead of `/etc/nix/netrc`.
    Furthermore, it should be owned by your user instead of `root`.  It should
    still have `0600` permissions.

 *  Nix may fail to find the `netrc` file automatically.  For permission
    errors, as an additional troubleshooting step, try adding this line to your
    `nix.conf`:

        netrc-file = /home/<your username>/.config/nix/netrc


### Builds from source

If you built Nix from source, `nix.conf` is located at
`/usr/local/etc/nix.conf` by default.  This may vary if you provided a
different `--prefix` or `--configdir` path to Nix's `./configure` script.  In
any case, the `netrc` file should be placed in the same directory as
`nix.conf`.  If Nix still encounters permission errors, try setting
`netrc-file` to the full path of the `netrc` file, like in the single-user
case.


## Galois-internal setup

 *  If you are setting up Nix on a shared machine, such as one of the FPGA
    hosts, there are shared team-wide credentials for this purpose, similar to
    the credentials used by TA-1 teams.  Contact Stuart or Reuben to get them.
    For troubleshooting purposes, follow all the normal instructions for TA-1
    teams, using the `besspin_galois` credentials.

 *  If you are setting up a personal machine, use your personal Artifactory API
    credentials.  To get your API key:

     1. Log in to [artifactory.galois.com](https://artifactory.galois.com)
     2. Click on your username at the top-right
     3. Enter your password as prompted
     4. Click the button to generate an API key, if needed
     5. Click the "copy" button next to the API key box

    When setting up your `netrc` file, use your LDAP username on the `login`
    line, and use your Artifactory API key as the `password`.  All other
    configuration steps should work unchanged.

 *  When using your personal Artifactory credentials, you may need to have your
    account added to the `besspin_generic-nix` repository before using the
    binary cache.  To check if you already have permissions, log in to the
    Artifactory web UI and see if the `besspin_generic-nix` repository is
    visible.  If not, contact Stuart or Reuben to be granted access.
