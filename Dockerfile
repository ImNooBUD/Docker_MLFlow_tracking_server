# Docker image for MLTracking Server

# Ubuntu 18.04 (bionic) from 2018-05-26
# https://github.com/docker-library/official-images/commit/aac6a45b9eb2bffb8102353c350d341a410fb169
ARG BASE_CONTAINER=ubuntu:bionic-20180526@sha256:c8c275751219dadad8fa56b3ac41ca6cb22219ff117ca98fe82b42f24e1ba64e
FROM $BASE_CONTAINER

LABEL maintainer="Andrey <imnoobud@gmail.com>"

USER root

# Install python req for mlflow
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    python3 \
    # for installing mlflow
    python3-pip \
    python3-setuptools \
 && rm -rf /var/lib/apt/lists/*

# Installing MLFLow and other requirements

COPY requirements.txt /opt/app/requirements.txt
WORKDIR /opt/app
RUN pip3 install -U setuptools
RUN pip3 install -r requirements.txt

ENV BACKEND_STORE='/backend_store'
ENV ARTIFACT_STORE='/artifact_store'


RUN mkdir $BACKEND_STORE
RUN mkdir $ARTIFACT_STORE

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8


VOLUME ["$BACKEND_STORE", "$ARTIFACT_STORE"]
EXPOSE 5000:5000


COPY server_start.sh /usr/local/bin

#Config strtup
CMD ["/usr/local/bin/server_start.sh"]




