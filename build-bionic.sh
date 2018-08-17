#!/bin/bash -e

echo "Build the Berg CMS for a Ubuntu based 32-bit System (bionic)..."

docker build --tag=bergcms-build-ubuntu-bionic-i686 --file=./Dockerfile-bionic .
docker images
mkdir -p bergcms-build
ARCHIVE=$(docker run --name=co-bergcms-build-ubuntu-bionic-i686  bergcms-build-ubuntu-bionic-i686)
docker cp co-bergcms-build-ubuntu-bionic-i686:$ARCHIVE bergcms-build/
ls -l bergcms-build
docker rm co-bergcms-build-ubuntu-bionic-i686
