# build ontop of official Java image
# offical gradle image based on ubuntu bionic
FROM gradle:6.7-jdk11
USER root

ENV \
    RUNTIME_DEPS="tar docker unzip curl git openssh-client ca-certificates docker-compose gettext-base"

RUN \
    apt update && \
    apt upgrade -y && \
    apt install -y $RUNTIME_DEPS && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apt clean

RUN mkdir /app
WORKDIR /app

