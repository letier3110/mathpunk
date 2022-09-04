#!/bin/bash

set -e
set -o pipefail

if [[ -z "${BUTLER_API_KEY}" ]]; then
  echo "Unable to deploy! No BUTLER_API_KEY environment variable specified!"
  exit 1
fi

prepare_butler() {
    echo "Preparing butler..."
    download_if_not_exist http://dl.itch.ovh/butler/linux-amd64/head/butler butler
    chmod +x butler
}

prepare_and_push() {
    echo "Push $3 build to itch.io..."
    ./butler push $2 $1:$3 --userversion $4
}

download_if_not_exist() {
    if [ ! -f $2 ]; then
        curl -L -O $1 > $2
    fi
}


project="toxcik/mathpunk-card-game"
artifact="./spire_mvp_flutter/mathpunk.zip"
platform="windows-linux-mac"
version="0.0.1"

prepare_butler

prepare_and_push $project $artifact $platform $version

echo "Done."
exit 0