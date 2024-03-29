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
        "private-resources" : [
            "galoisCredentialsNetrc.txt"
        ],
        "secrets" : [
            "id=galoisCredentialsNetrc,src=./galoisCredentialsNetrc.txt"
        ]
    },

    # Vivado Lab 2019.1 on top of gfe or tool-suite
    "vivado-lab-2019-1" : {
        "perm": "private",
        "variants" : ["gfe", "tool-suite"],
        "build-args" : {
            "all" : {},
            "gfe" : {
                "BASE" : f"{PUBLIC_PATH}gfe",
                "DEFAULT_USER" : "root"
            },
            "tool-suite" : {
                "BASE" : f"{PUBLIC_PATH}tool-suite",
                "DEFAULT_USER" : "besspinuser"
            }
        },
        "private-resources" : [
            "install_config_vivado.txt",
            "Xilinx_Vivado_Lab_Lin_2019.1_0524_1430.tar.gz",
            "install_config_hw.txt",
            "Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz"
        ]
    },

    # Vivado SDK 2019.1 
    "vivado-sdk-2019-1" : {
        "perm": "private",
        "private-resources" : [
            "install_config_full.txt",
            "Xilinx_Vivado_SDK_2019.1_0524_1430.tar.gz",
            "install_config_hw.txt",
            "Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz",
            "Xilinx.lic"
        ]
    },

    # Vivado SDK 2018.3
    "vivado-sdk-2018-3" : {
        "perm": "private",
        "private-resources" : [
            "install_config_full.txt",
            "Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz",
            "install_config_hw.txt",
            "Xilinx_HW_Server_Lin_2018.3_1207_2324.tar.gz",
            "Xilinx.lic"
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
        ],
        "sudo" : 1  
    },

    # The Cheri image used for CHERI FreeRTOS
    "freertos-cheri" : {
        "perm" : "public"
    },

    # The firesim image
    "firesim" : {
        "perm" : "public",
        "public-resources" : [
            "https://buildlogs.centos.org/c7.1810.u.x86_64/kernel/20190201145240/3.10.0-957.5.1.el7.x86_64/kernel-devel-3.10.0-957.5.1.el7.x86_64.rpm"
        ]
    },

    # The chisel image
    "chisel" : {
        "perm" : "public"
    },

    # The voting system image
    "voting-system" : {
        "perm" : "public"
    },

    # The UI image
    "ui" : {
        "perm" : "public"
    }

} #IMAGES_DATA

def error(msg):
    logging.error(msg)
    exit(1)

def shellCommand (argsList, errorMessage, check=True, **kwargs):
    logging.debug (f"shellCommand: <{' '.join(argsList)}>.")
    try:
        subprocess.run(argsList, check=check, **kwargs)
    except:
        traceback.print_exc()
        error(errorMessage)

def curlArtifactory(resource, path):
    shellCommand (  [   
                        "curl", "-H", f"X-JFrog-Art-Api:{os.environ['API_KEY']}",
                        "-o", os.path.join(path,resource), 
                        f"{PRIVATE_RESOURCES_PATH}/{resource}"
                    ],
                    f"Failed to fetch <{resource}>."
                )

def wgetPublic(resource, path):
    shellCommand (  [   
                        "wget",
                        "-O", os.path.join(path,os.path.basename(resource)), 
                        resource
                    ],
                    f"Failed to download <{resource}>."
                )

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
        data = IMAGES_DATA[image]
        path = os.path.join(dockerDir,image)

        if ((xArgs.publicOnly) and ("perm" in data) and (data["perm"] == "private")):
            logging.debug(f"Public only mode. Skipping <{image}>.")
            continue
        logging.info ('\n' + '-'*30 + f">>> <{image}> <<<" + '-'*30)

        # Fetch the resources
        if (xArgs.fetchResources or xArgs.build):
            logging.debug(f"Fetching resources for <{image}>...")
            resourcesToFetch = {"public" : [], "private" : []}
            for perm in resourcesToFetch.keys():
                if (f"{perm}-resources" in data):
                    for resource in data[f"{perm}-resources"]:
                        if (perm=="private"):
                            file = os.path.join(path,resource)
                        elif (perm =="public"): #resource is a url
                            file = os.path.join(path,os.path.basename(resource))
                        if (os.path.isfile(file)):
                            logging.debug(f"<{file}> found. Skipping the fetch...")
                        else:
                            resourcesToFetch[perm].append(resource)
            if ((len(resourcesToFetch["private"])>0) and (not goodApikey)): # check for the API key to exit early if not found
                if ("API_KEY" not in os.environ):
                    error(f"<API_KEY> is unset! Cannot fetch private resources for <{image}>.")
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

            for resource in resourcesToFetch["private"]:
                logging.debug(f"Fetching <{resource}> from artifactory...")
                curlArtifactory(resource,path)
            for resource in resourcesToFetch["public"]:
                logging.debug(f"Fetching the public <{resource}>...")
                wgetPublic(resource,path)
            logging.debug(f"Done fetching resources for <{image}>.")

        if ("variants" in data):
            variants = data["variants"]
        else:
            variants = [None]
        for variant in variants:
            if (variant):
                logging.info ('\n' + '-'*10 + f">> <{variant}> <<" + '-'*10)

            # image tag
            if (("perm" not in data) or (data["perm"] not in ["public", "private"])):
                error(f"DATA_IMAGE for <{image}> is missing <perm>.")
            elif (data["perm"]=="public"):
                imageTag = f"{PUBLIC_PATH}{image}"
            elif (data["perm"]=="private"):
                imageTag = f"{PRIVATE_DOCKER_PATH}{image}"
            if (variant):
                imageTag += f":{variant}"

            # Build image
            if (xArgs.build):
                # Pre-commands
                if ("pre-commands" in data):
                    for command in data["pre-commands"]:
                        shellCommand(command, f"Failed to <{command}>.",shell=True, cwd=path)

                # The build itself
                dockerCommand = ["sudo"] if ("sudo" in data) else []
                dockerCommand += [  "docker", "build", 
                                    "--progress=plain", "--network=host",
                                    "--tag", imageTag
                                ]

                # build-args
                if ("build-args" in data):
                    if (variant):
                        buildArgs = data["build-args"]["all"]
                        buildArgs.update(data["build-args"][variant])
                    else:
                        buildArgs = data["build-args"]
                    for key, val in buildArgs.items():
                        dockerCommand += ["--build-arg", f"{key}={val}"]

                # secrets
                if ("secrets" in data):
                    for secret in data["secrets"]:
                        dockerCommand += ["--secret", secret]

                dockerCommand.append(".") # cwd
                logging.debug(f"Docker Command: <{' '.join(dockerCommand)}>.")
                shellCommand (
                    dockerCommand,
                    f"Failed to build <{image}>.",
                    cwd=path, env={"DOCKER_BUILDKIT" : "1"}
                    )

                # Post-commands
                if ("post-commands" in data):
                    for command in data["post-commands"]:
                        shellCommand(command, f"Failed to <{command}>.",shell=True, cwd=path)

            # Push image
            if (xArgs.push):
                pushCommand = ["sudo"] if ("sudo" in data) else []
                pushCommand += ["docker", "push", imageTag]
                shellCommand(pushCommand, f"Failed to push <{image}>.")


if __name__ == "__main__":
    # Reading the bash arguments
    xArgParser = argparse.ArgumentParser (description="Build one or all docker images in this directory")
    xArgParser.add_argument ('-b', '--build', help='Build the specified containers.', action='store_true')
    xArgParser.add_argument ('-p', '--push', help='Push the specified containers.', action='store_true')
    xArgParser.add_argument ('-r', '--fetchResources', help='Fetch the resources for the specified containers. (implied with -b)', action='store_true')
    xArgParser.add_argument ('-n', '--publicOnly', help='No credentials for private containers.', action='store_true')
    imagesGroup = xArgParser.add_mutually_exclusive_group()
    imagesGroup.add_argument ('-a', '--all', help='All possible (see -n) images. [default]', action='store_true')
    imagesGroup.add_argument ('-s', '--selectImages', help='Select the following image(s).', nargs="*")
    xArgs = xArgParser.parse_args()
    main(xArgs)