#! /usr/bin/env python3

"""
Utility to build/publish the docker containers in this directory.
Alternatively, you can always look at the READMEs and execute the commands manually.
"""

import os, sys, subprocess, traceback 
import logging, argparse, json

PUBLIC_PATH = "galoisinc/besspin:"
PRIVATE_DOCKER_PATH = "artifactory.galois.com:5008/" 
PRIVATE_RESOURCES_PATH = "https://artifactory.galois.com/artifactory/besspin_generic-nix/docker-private-resources"
TEST_FILE = "test.json"

# Note that the order of these images preserves the inter-dependencies.
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
            "galoisCredentialsNetrc.txt"
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

    # The Cheri image used in FETT
    "fett-cheri" : {
        "perm" : "public",
        "pre-commands" : [
            "./copy-files.sh"
        ],
        "post-commands" : [
            "./clear.sh"
        ]
    }

} #IMAGES_DATA

def error(msg):
    logging.error(msg)
    exit(1)

def curlArtifactory(resource, path):
    try:
        subprocess.run(["curl", "-H", f"X-JFrog-Art-Api:{os.environ['API_KEY']}",
                        "-o", os.path.join(path,resource), 
                        f"{PRIVATE_RESOURCES_PATH}/{resource}"],
                        check=True)
    except Exception as exc:
        traceback.print_exc()
        error(f"Failed to fetch <{resource}>.")

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
    if (not any([xArgs.build, xArgs.push, xArgs.fetchResources])):
        logging.warning("Nothing to do.")
        exit(0)
    logging.debug(f"<fetchResources={xArgs.fetchResources}>, <Build={xArgs.build}>, <Push={xArgs.push}>.")

    # Choose the image(s)
    if (xArgs.selectImages):
        for image in xArgs.selectImages:
            if (image not in IMAGES_DATA):
                error(f"Unknown <{image}>. Please choose from [{','.join(list(IMAGES_DATA.keys()))}]")
        images = xArgs.selectImages
    else:
        images = list(IMAGES_DATA.keys())
    logging.debug(f"Selected Images: [{','.join(images)}].")

    goodApikey = False
    for image in images:
        logging.info ('\n' + '-'*30 + f">>> <{image}> <<<" + '-'*30)
        data = IMAGES_DATA[image]
        path = os.path.join(dockerDir,image)

        # Fetch the resources
        if (xArgs.fetchResources or xArgs.build):
            logging.debug(f"Fetching resources for <{image}>...")
            resourcesToFetch = []
            if ("resources" in data):
                for resource in data["resources"]:
                    file = os.path.join(path,resource)
                    if (os.path.isfile(file)):
                        logging.debug(f"<{file}> found. Skipping the fetch...")
                    else:
                        resourcesToFetch.append(resource)
            if ((len(resourcesToFetch)>0) and (not goodApikey)): # check for the API key to exit early if not found
                if ("API_KEY" not in os.environ):
                    error(f"<API_KEY> is unset! Cannot fetch resources for <{image}>.")
                if (os.path.isfile(f"/tmp/{TEST_FILE}")):
                    os.remove(f"/tmp/{TEST_FILE}")
                # Artifactory returns a json with bad status for bad API keys, so let's fetch the test file
                curlArtifactory(TEST_FILE,"/tmp")
                with open(f"/tmp/{TEST_FILE}","r") as f:
                    testDict = json.load(f)
                if (("text" in testDict) and (testDict["text"] == "OK!")):
                    goodApikey = True
                else:
                    logging.debug(f"Curl output: {testDict}")
                    error(f"Invalid <test.json>. Please verify your <API_KEY>.")

            for resource in resourcesToFetch:
                logging.debug(f"Fetching <{resource}>...")
                curlArtifactory(resource,path)
            logging.debug(f"Done fetching resources for <{image}>.")

        
        # Build image
        # Pre commands
        # DOCKER_BUILDKIT=1, progress=plain, --ssh default, --network=host
        # Post commands

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