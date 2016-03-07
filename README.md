# bergcms-build-ubuntu-i686
[![Build Status](https://travis-ci.org/leutloff/bergcms-build-ubuntu-i686.png)](https://travis-ci.org/leutloff/bergcms-build-ubuntu-i686)

Build the Berg CMS for a Ubuntu based 32-bit System.

To install Docker, see [Install Docker Engine](https://docs.docker.com/engine/installation)

To start the build run the following docker command:

    docker build --tag=bergcms-build-ubuntu-i686 .
    docker images
    mkdir -p bergcms-build
    ARCHIVE=$(docker run --name=co-bergcms-build-ubuntu-i686  bergcms-build-ubuntu-i686)
    docker cp co-bergcms-build-ubuntu-i686:$ARCHIVE bergcms-build/ 
    ls -l bergcms-build
    docker rm co-bergcms-build-ubuntu-i686
