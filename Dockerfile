# docker build -t patrikx3/docker-debian-testing-mongodb-stable .
# docker container ls
# docker exec -it <containerIdOrName> bash
# docker attach <id>
# docker run -t -i patrikx3/docker-debian-testing-mongodb-stable bash
# https://github.com/mongodb/mongo/wiki/Build-Mongodb-From-Source
# https://unix.stackexchange.com/questions/378644/how-to-install-mongodb-3-4-in-debian-stretch-9
# recipe
# docker commit ${container_id} patrikx3/docker-debian-testing-mongodb-stable:built
# docker commit ${container_id} patrikx3/docker-debian-testing-mongodb-stable:installed

FROM debian:testing
MAINTAINER patrikx3/docker-debian-testing-mongodb-stable - Patrik Laszlo - alabard@gmail.com

ENV DEBIAN_FRONTEND=noninteractive
ENV FORCE_UNSAFE_CONFIGURE=1
ENV SHELL=/bin/bash

ARG MONGODB_BRANCH=v4.1
ARG MONGODB_RELEASE=r4.1.0

ENV PATH="/build/install:/build/mongo:${PATH}"

RUN apt-get -y update
RUN apt-get -y upgrade

# libboost1.55-dev => libboost-dev
# openjdk-8-jdk => openjdk-7-jdk
# clang - might not needed
RUN apt -y install build-essential gcc python scons git glibc-source libssl-dev python-pip libffi-dev python-dev
RUN pip install -U pip
RUN mkdir build

# clean up
RUN apt-get autoremove -y
RUN apt-get autoclean -y
RUN apt-get clean -y

WORKDIR build

WORKDIR /build
RUN git clone -b ${MONGODB_BRANCH} https://github.com/mongodb/mongo.git
WORKDIR /build/mongo
RUN git checkout tags/${MONGODB_RELEASE}

# hack to old version python pip cryptography from 1.7.2 to use the latest
RUN sed -i 's#cryptography == 1.7.2#\#cryptography == 1.7.2#g' buildscripts/requirements.txt
# this is only because 4.1.0 uses 1.7.2 and
# https://github.com/pyca/cryptography/issues/4193#issuecomment-381236459
# support minimum latest (2.2)
RUN pip install cryptography


RUN pip install -r buildscripts/requirements.txt
RUN pip2 install --user regex
RUN scons all --disable-warnings-as-errors -j 8 --ssl
#RUN scons core --disable-warnings-as-errors -j 8 --ssl
RUN scons install --disable-warnings-as-errors -j 8 --prefix /usr/bin

CMD /bin/bash



