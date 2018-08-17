# Berg CMS - Build on/for Ubuntu 32-bit

[![Build Status](https://travis-ci.org/leutloff/bergcms-build-ubuntu-i686.png)](https://travis-ci.org/leutloff/bergcms-build-ubuntu-i686)

Build the [Berg CMS](https://github.com/leutloff/bergcms) for a Ubuntu based 32-bit System.

To install Docker, see [Install Docker Engine](https://docs.docker.com/engine/installation).

To start the build run the following docker commands for *18.04* (Bionic):

    docker build --tag=bergcms-build-ubuntu-bionic-i686 --file=./Dockerfile-bionic .
    docker images
    mkdir -p bergcms-build
    ARCHIVE=$(docker run --name=co-bergcms-build-ubuntu-bionic-i686  bergcms-build-ubuntu-bionic-i686)
    docker cp co-bergcms-build-ubuntu-bionic-i686:$ARCHIVE bergcms-build/
    ls -l bergcms-build
    docker rm co-bergcms-build-ubuntu-bionic-i686

To start the build run the following docker commands for *16.04* (Xenial):

    docker build --tag=bergcms-build-ubuntu-xenial-i686 --file=./Dockerfile-xenial .
    docker images
    mkdir -p bergcms-build
    ARCHIVE=$(docker run --name=co-bergcms-build-ubuntu-xenial-i686  bergcms-build-ubuntu-xenial-i686)
    docker cp co-bergcms-build-ubuntu-xenial-i686:$ARCHIVE bergcms-build/
    ls -l bergcms-build
    docker rm co-bergcms-build-ubuntu-xenial-i686

To start the build run the following docker commands for *14.04* (Trusty):

    docker build --tag=bergcms-build-ubuntu-trusty-i686 --file=./Dockerfile-trusty .
    docker images
    mkdir -p bergcms-build
    ARCHIVE=$(docker run --name=co-bergcms-build-ubuntu-trusty-i686  bergcms-build-ubuntu-trusty-i686)
    docker cp co-bergcms-build-ubuntu-trusty-i686:$ARCHIVE bergcms-build/
    ls -l bergcms-build
    docker rm co-bergcms-build-ubuntu-trusty-i686
