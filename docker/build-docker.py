#! /usr/bin/env python3

"""
Utility to build/publish the docker containers in this directory.
Alternatively, you can always look at the READMEs and execute the commands manually.
"""

import os, sys, subprocess 
import logging, argparse

PUBLIC_PATH = "galoisinc/besspin:"
PRIVATE_PATH = "artifactory.galois.com:5008/" 

IMAGES_DATA = {
    # GFE Image
    "gfe" : {
        "perm" : "public"
    },

    # GCC 8.3 Image
    "gcc83" : {
        "perm" : "public"
    },

    # Tool-Suite Image (with Nix Store)
    "tool-suite" : {
        "perm" : "public",
        "resources" : [
            "galoisCredentialsNetrc.txt "
        ],
        "secrets" : [
            "id=galoisCredentialsNetrc,src=./galoisCredentialsNetrc.txt"
        ]
    },

    # Vivado Lab 2019.1 on top of gfe or tool-suite
    "vivado-lab-2019-1" : {
        "perm": "private",
        "variants" : {
            "loc" : "prefix",
            "values" : ["gfe", "tool-suite"]
        },
        "build-args" : {
            "all" : {},
            "gfe" : {
                f"BASE={PUBLIC_PATH}gfe",
                "DEFAULT_USER=root"
            },
            "tool-suite" : {
                f"BASE={PUBLIC_PATH}tool-suite",
                "DEFAULT_USER=besspinuser"
            }
        },
        "resources" : [
            "install_config_vivado.txt",
            "Xilinx_Vivado_Lab_Lin_2019.1_0524_1430.tar.gz",
            "install_config_hw.txt",
            "Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz"
        ]
    },

}

def main(xArgs):
    dockerDir = os.path.abspath(os.path.dirname(__file__))

    # Setup logging and stdout/stderr
    logFile = os.path.join(dockerDir,"build-docker.log")
    logging.basicConfig(filename=logFile,filemode='w',
        format='[%(asctime)s]: %(message)s',
        datefmt='%I:%M:%S %p',
        level=logging.DEBUG)
    # define a Handler which writes INFO messages or higher to the sys.stderr
    console = logging.StreamHandler()
    console.setLevel(logging.INFO)
    # tell the handler to use our format
    console.setFormatter(logging.Formatter('[%(asctime)s]: %(message)s',datefmt='%I:%M:%S %p'))
    # add the handler to the root logger
    logging.getLogger().addHandler(console)

    # Determine the mode
    if ((not xArgs.build) and (not xArgs.push) and (not xArgs.fetchResources)):
        logging.warning("Nothing to do.")
        exit(0)
    logging.debug(f"<fetchResources={xArgs.fetchResources}>, <Build={xArgs.build}>, <Push={xArgs.push}>.")

    # Choose the image(s)

    # For each image
        # Fetch the resources


        # Build image
        # DOCKER_BUILDKIT=1, progress=plain, --ssh default, --network=host

        # Push image


if __name__ == "__main__":
    # Reading the bash arguments
    xArgParser = argparse.ArgumentParser (description="Build one or all docker images in this directory")
    xArgParser.add_argument ('-b', '--build', help='Build the specified containers.', action='store_true')
    xArgParser.add_argument ('-p', '--push', help='Push the specified containers.', action='store_true')
    xArgParser.add_argument ('-r', '--fetchResources', help='Fetch the resources for the specified containers. (implied with -b)', action='store_true')
    xArgParser.add_argument ('-n', '--publicOnly', help='No credentials for private containers.', action='store_true')
    imagesGroup = xArgParser.add_mutually_exclusive_group()
    imagesGroup.add_argument ('-a', '--all', help='All possible (see -n) images.', action='store_true')
    imagesGroup.add_argument ('-s', '--selectImages', help='Select the following image(s).', nargs="*")
    xArgParser.add_argument ('-v','--imageVariants', help='Specify image variants if applicable (ignored with -a).')
    xArgs = xArgParser.parse_args()
    main(xArgs)