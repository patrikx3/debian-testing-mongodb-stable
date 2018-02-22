#!/usr/bin/env bash
# based on https://github.com/mongodb/mongo/wiki/Build-Mongodb-From-Source

# the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# if an error exit right away, don't continue the build
set -e

# some info
echo
#echo "Works like command, use a tag: sudo ./scripts/build-.sh v3.6 r3.6.3"
echo "Works like command, use a tag: sudo ./scripts/build-server.sh r3.6.3"
echo

# check if we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be ran via root 'sudo' command or using in 'sudo -i'."
   exit 1
fi

# require mongo branch
#if [ -z "${1}" ]; then
#    echo "First argument must be the MONGODB_BRANCH for example 'v3.6'"
#    exit 1
#fi
#MONGODB_BRANCH="${1}"

# require mongo release
#if [ -z "${2}" ]; then
#    echo "The second argument must be the MONGODB_RELEASE for example 'r3.6.3'"
#    exit 1
#fi
#MONGODB_RELEASE="${2}"

# require mongo release
if [ -z "${1}" ]; then
    echo "The first argument must be the MONGODB_RELEASE for example 'r3.6.3'"
    exit 1
fi
MONGODB_RELEASE="${1}"

# delete all mongo other programs, we self compile
apt remove --purge mongo*

# the required packages for debian
apt -y install gcc python scons git glibc-source libssl-dev python-pip

# generate build directory variable
BUILD=$DIR/../build

# delete previous build directory
rm -rf $BUILD/mongo

# generate new build directory
mkdir -p $BUILD

# the mongodb.conf and systemd services files in a directory variable
ROOT_FS=$DIR/../artifacts/root-filesystem

# find out how many cores we have and we use that many
CORES=$(grep -c ^processor /proc/cpuinfo)

# go to the build directory
pushd $BUILD

    # clone the mongo by branch
    #git clone -b ${MONGODB_BRANCH} https://github.com/mongodb/mongo.git

    # clone the mongo by branch
    git clone https://github.com/mongodb/mongo.git

    # the mongo directory is a variables
    MONGO=$BUILD/mongo

    # go to the mongo directory
    pushd $MONGO

        # checkout the mongo release
        git checkout tags/${MONGODB_RELEASE}

        # install the python requirements
        pip install -r buildscripts/requirements.txt

        # somewhere in the build it says if we install this, it is faster to build
        pip2 install --user regex

        # build everything
        scons all --disable-warnings-as-errors -j $CORES --ssl

        # install the mongo programs all
        scons install --disable-warnings-as-errors -j $CORES --prefix /usr

        # create a copy of the old config
        TIMESTAMP=$(($(date +%s%N)/1000000))
        cp /etc/mongodb.conf /etc/mongodb.conf.$TIMESTAMP.save

        # copy the mongodb.conf configured and the systemd service file
        chmod o-rwx -R $ROOT_FS
        cp -avr $ROOT_FS/. /

        # generate mongodb user and group
        useradd mongodb -d /var/lib/mongodb -s /bin/false || true

        # create the required mongodb database directory and add safety
        mkdir -p /var/lib/mongodb
        chmod o-rwx -R /var/lib/mongodb
        chown -R mongodb:mongodb /var/lib/mongodb

        # create the required mongodb log directory and add safety
        mkdir -p /var/log/mongodb
        chmod o-rwx -R /var/log/mongodb
        chown -R mongodb:mongodb /var/log/mongodb

        # create the required run socket directory and add safety
        mkdir -p /run/mongodb
        chmod o-rwx -R /run/mongodb
        chown -R mongodb:mongodb /run/mongodb

        # add safety to the mongodb config file
        chmod o-rwx /etc/mongodb.conf
        chown mongodb:mongodb /etc/mongodb.conf

        # add safety to the mongodb systemd service file
        chmod o-rwx /etc/systemd/system/mongodb-server.service
        chown root:root /etc/systemd/system/mongodb-server.service

        # reload systemd services
        systemctl daemon-reload

        # enable the mongodb-server
        systemctl enable mongodb-server

        # start the mongodb-server
        service mongodb-server start

    # exit of the mongo directory
    popd

# exit the build directory
popd