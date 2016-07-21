FROM ubuntu:14.04

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

MAINTAINER Jaakko

RUN \
apt-get update && \
apt-get install -y \
python-pip \
git \
wget \
curl \
ca-certificates \
xfonts-100dpi \
xfonts-75dpi \
xfonts-scalable \
xfonts-cyrillic \
xvfb --no-install-recommends && \
apt-get clean autoclean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Installing earlier firefox version
RUN wget https://launchpad.net/~ubuntu-mozilla-security/+archive/ubuntu/ppa/+build/9629832/+files/firefox_46.0+build5-0ubuntu0.14.04.2_amd64.deb
RUN dpkg -i --force-all firefox_46.0+build5-0ubuntu0.14.04.2_amd64.deb
RUN dpkg --configure -a
RUN sh -c "apt-get update;apt-get dist-upgrade;apt-get autoremove;apt-get autoclean;apt-get -f -y install"

RUN pip install robotframework robotframework-extendedselenium2library
