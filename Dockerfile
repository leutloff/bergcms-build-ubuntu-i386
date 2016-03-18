FROM i386/ubuntu:trusty

MAINTAINER Christian Leutloff <leutloff@sundancer.oche.de>

# Install the build environment
# Trusty: libboost-dev 1.54.01, gcc 4.8.2, (cmake 2.8.12.2)
# Python is required by ctemplate, only
# Curl with ca-certificates is used to download CMake 3.5
RUN apt-get update && apt-get install --no-install-recommends -y \
    gcc \
    g++ \
    python \
    perl \
    libtool \
    autoconf \
    automake \
    make \
    patch \
    curl \
    ca-certificates \
    file \
    less \
    git \
    bzip2 \
    xz-utils \
    libc6-dev \
    zlib1g-dev \
    liblzma-dev \
    libssl-dev \
    libboost-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev libboost-iostreams-dev \
       libboost-log-dev libboost-program-options-dev libboost-regex-dev libboost-signals-dev libboost-system-dev \
       libboost-thread-dev libboost-test-dev \
 && rm -rf /var/lib/apt/lists/*


# Install CMake 3.5, export OPTDIR=/opt, export CMAKEDIR=/opt/cmake-3.5, get shellscript installer, execute the downloaded file, add link from /usr/local/bin
ENV OPTDIR /opt
ENV CMAKEDIR /opt/cmake-3.5
RUN mkdir -p "$OPTDIR" "$CMAKEDIR" && (cd "$OPTDIR" && \
    curl -LO https://cmake.org/files/v3.5/cmake-3.5.0-Linux-i386.sh && \
    /bin/sh ./cmake-*-Linux-i386.sh --prefix=$CMAKEDIR --skip-license && \
    ln -sf $CMAKEDIR/bin/cmake /usr/local/bin/cmake && \
    ln -sf $CMAKEDIR/bin/cpack /usr/local/bin/cpack && \
    ln -sf $CMAKEDIR/bin/ctest /usr/local/bin/ctest && \
    cd -)
RUN cmake --version

ENV BASEDIR /usr/src
ENV BGDIR /usr/src/berg
ENV BUILDDIR /usr/src/bergcms-build  
ENV EXPORTDIR /opt/bergcms 
    
# Get the Source
RUN mkdir -p "$BASEDIR" && cd "$BASEDIR" && git clone git://github.com/leutloff/berg.git && cd berg && git checkout 227ccac && git submodule update --init --recursive

# Build ctemplate
RUN cd "$BGDIR/src/external/ctemplate" \
 && ./configure --prefix "$BGDIR/src/external/ctemplate" 1>/dev/null \
 && make \
 && make install

RUN ls -l "$BGDIR/src/external/ctemplate" "$BGDIR/src/external/ctemplate/include"
RUN ls -l /usr/src/berg/src/external/ctemplate/include
 
# Build the Berg CMS
RUN mkdir -p "$BUILDDIR" && cd "$BUILDDIR" \
 && cmake -D CMAKE_BUILD_TYPE=Distribution -D CMAKE_VERBOSE_MAKEFILE=FALSE "$BGDIR/src" \
 && make \
 && make package \
 && export BERG_ARCHIVE=$(ls -t Berg*.zip | head -1) \
 && ls -al . "$BUILDDIR"  test "$BUILDDIR/test" 

# Running the C++ unit tests...
RUN ls -al "$BUILDDIR" && cd "$BUILDDIR/test" \
 && ./bergunittests

ENTRYPOINT [ "/bin/bash", "-c", "/bin/ls /usr/src/bergcms-build/*.zip" ]
