This directory contains automated testing scripts that run through the steps of
the tutorial from the main tool-suite README.

There are three main components:

 * `install_debian_packages.py`: Installs the Debian packages necessary to run
   the remaining scripts.  This only needs to be run once on a given host
   machine (but running it multiple times is harmless).

 * `install_nix.py`: Installs Nix and configures it to use the binary cache.
   This only needs to be run once on a given host machine.  This script will
   request your Artifactory credentials (personal API key or team access token)
   so they can be added to the Nix configuration.

 * `test_tutorial.py`: Runs the steps of the tutorial and checks that they
   succeed.  Currently only the architecture and feature extraction portions
   have been automated.

The install scripts will request your password for `sudo` in order to make
systemwide changes.  `test_tutorial.py` does not require `sudo`.  
