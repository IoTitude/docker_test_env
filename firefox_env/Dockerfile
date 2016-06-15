FROM ubuntu:14.04

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

MAINTAINER Jaakko

# Broken with the newest firefox version (47.0). Get working image from dockerhub.

RUN \
apt-get update && \
apt-get install -y \
python-pip \
git \
firefox \
wget \
ca-certificates \
xfonts-100dpi \
xfonts-75dpi \
xfonts-scalable \
xfonts-cyrillic \
xvfb --no-install-recommends && \
apt-get clean autoclean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install robotframework robotframework-extendedselenium2library

ADD ./scripts/ /home/root/scripts

RUN chmod -R 755 /home/root/scripts

ENTRYPOINT ["/home/root/scripts/start.sh"]


