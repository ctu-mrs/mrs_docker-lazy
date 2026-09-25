#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd ${MY_PATH}

## --------------------------------------------------------------
## |                            setup                           |
## --------------------------------------------------------------

source ./common_vars.sh

## --------------------------------------------------------------
## |                            load                            |
## --------------------------------------------------------------

# OUTPUT_IMAGE and EXPORT_PATH are exported by common_vars.sh
# and picked up by the playbook through the 'env' lookup

ansible-playbook -i ../inventory.ini load_docker_image.yaml --ask-become-pass
