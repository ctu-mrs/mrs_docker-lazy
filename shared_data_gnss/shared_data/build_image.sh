#!/bin/bash

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd ${MY_PATH}

## --------------------------------------------------------------
## |                            setup                           |
## --------------------------------------------------------------

LOCAL_TAG=shared_data_eagle
REGISTRY=fly4future

# single-platform image can be stored locally
# ARCH=linux/amd64
ARCH=linux/arm64
OUTPUT="--output type=docker"

# multi-platform image can not be stored locally, needs to be pushed
# ARCH=linux/arm64,linux/amd64
# OUTPUT="--push"

## --------------------------------------------------------------
## |                            build                           |
## --------------------------------------------------------------

# build the docker image using the builder and export the results to the local docker registry
docker build . --file Dockerfile --tag $REGISTRY/$LOCAL_TAG --platform=${ARCH} ${OUTPUT}

echo ""
echo "$0: shared data were packed into '$LOCAL_TAG'"
echo ""

EXPORT_PATH=~/docker
mkdir -p $EXPORT_PATH

## --------------------------------------------------------------
## |                           export                           |
## --------------------------------------------------------------

docker save ${REGISTRY}/${LOCAL_TAG} | gzip > ${EXPORT_PATH}/${LOCAL_TAG}.tar.gz

echo "Image exported to ${EXPORT_PATH}/${LOCAL_TAG}.tar.gz"
