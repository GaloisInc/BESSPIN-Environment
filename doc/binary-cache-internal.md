# Galois-internal binary cache setup

The binary cache setup instructions in the main README.md are intended for TA-1
teams, which use per-team credentials to access the BESSPIN Nix binary cache.
Internal Galois users should use their personal Artifactory credentials
instead.  The username is your normal LDAP username, and the password is your
Artifactory API key.

To find your API key:

 1. Log in to [artifactory.galois.com](https://artifactory.galois.com)
 2. Click on your username at the top-right
 3. Enter your password as prompted
 4. Click the button to generate an API key, if needed
 5. Click the "copy" button next to the API key box

Then use your API key to create the /etc/nix/netrc file, as in the main README:

    machine artifactory.galois.com
    login <your LDAP username>
    password <your Artifactory API key>

To test the setup, run:

    sudo curl --netrc-file /etc/nix/netrc https://artifactory.galois.com/besspin_generic-nix/nix-cache-info

This should print `StoreDir: /nix/store`.  If it reports an error instead,
check that you have permission to access the `besspin_generic-nix` repository
on Artifactory.

## Shared machines

For shared machines running a system-wide Nix daemon, there is a team-wide
BESSPIN login for the binary cache.  Contact Reuben to get it.

## Single-user Nix installs

If you are using a single-user (non-daemon) Nix install, the Nix config file is
located at `~/.config/nix/nix.conf` instead of `/etc/nix/nix.conf`.  You may
also need to explicitly set `netrc-file = /home/<username>/.config/nix/netrc`,
as Nix may fail to find the netrc file automatically.  (In this case, it will
report that `https://artifactory.galois.com/besspin_generic-nix does not appear
to be a binary cache`.
