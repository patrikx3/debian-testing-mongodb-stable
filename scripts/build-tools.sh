#!/usr/bin/env bash
# based on https://github.com/mongodb/mongo-tools

# the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# if an error exit right away, don't continue the build
set -e

# some info
echo
echo "Works like command: sudo ./scripts/build-tools.sh r4.0.6"
echo

# check if we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be ran via root 'sudo' command or using in 'sudo -i'."
   exit 1
fi

# require mongo release
if [ -z "${1}" ]; then
    echo "The first argument must be the MONGODB_RELEASE for example 'r4.0.6'"
    exit 1
fi
MONGODB_RELEASE="${1}"

## delete all mongo other programs, we self compile
##apt remove --purge mongo*

## the required packages for debian
##apt -y install gcc python scons git glibc-source libssl-dev python-pip

apt -y install golang libpcap-dev

export GOROOT=$(go env GOROOT)


# generate build directory variable
BUILD=$DIR/../build/src/github.com/mongodb/

# delete previous build directory
rm -rf $BUILD/mongo-tools

# generate new build directory
mkdir -p $BUILD

# find out how many cores we have and we use that many
CORES=$(grep -c ^processor /proc/cpuinfo)

# go to the build directory
pushd $BUILD

    # clone the mongo by branch
    git clone https://github.com/mongodb/mongo-tools

    # the mongo directory is a variables
    MONGO_TOOLS=$BUILD/mongo-tools

    # go to the mongo directory
    pushd $MONGO_TOOLS

        # checkout the mongo release
        git checkout tags/${MONGODB_RELEASE}

        bash ./build.sh
        chown root:adm -R ./bin
        chmod o-rwx -R ./bin
        chmod ug+rx ./bin/*
        cp -r ./bin/. /usr/bin
#        for PROGRAM in bsondump mongodump mongoexport mongofiles mongoimport mongoreplay mongorestore mongostat mongotop
#        do
#            go build -o bin/${PROGRAM} -tags "ssl sasl" ${PROGRAM}/main/${PROGRAM}.go
#        done

    # exit of the mongo directory
    popd

# exit the build directory
popd

# delete current build directory
rm -rf $BUILD/mongo-tools
