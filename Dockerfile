# build ontop of official Java image
# offical gradle image based on ubuntu focal
FROM gradle:6.7.1-jdk11
USER root

ENV \
	COMPOSE_VERSION="1.27.4" \
    BUILD_DEPS="apt-transport-https gnupg-agent software-properties-common" \
    RUNTIME_DEPS="tar docker-ce unzip curl git openssh-client ca-certificates gettext-base"


RUN \
    apt update && \
    apt install -y $BUILD_DEPS && \
    curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt install -y $RUNTIME_DEPS && \
    curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    ln -f -s /usr/local/bin/docker-compose /usr/bin/docker-compose && \
    ln -s /usr/bin/envsubst /usr/local/bin/envsubst && \
    apt remove -y $BUILD_DEPS && \
    apt clean && \
    apt autoremove -y

RUN mkdir /app
WORKDIR /app

