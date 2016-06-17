#!/bin/bash -e

echo "Build the Berg CMS for a Ubuntu based 32-bit System..."

docker build --tag=bergcms-build-ubuntu-xenial-i686 --file=./Dockerfile-xenial .
docker images
mkdir -p bergcms-build
ARCHIVE=$(docker run --name=co-bergcms-build-ubuntu-xenial-i686  bergcms-build-ubuntu-xenial-i686)
docker cp co-bergcms-build-ubuntu-xenial-i686:$ARCHIVE bergcms-build/ 
ls -l bergcms-build
docker rm co-bergcms-build-ubuntu-xenial-i686
