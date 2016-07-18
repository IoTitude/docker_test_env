FROM ubuntu:14.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y \

  curl git wget unzip screen expect

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

RUN apt-get update && apt-get install -y \

  nodejs

RUN mkdir -p /usr/src

EXPOSE 3000

COPY ./scripts/ /usr/src/scripts

RUN chmod -R 755 /usr/src/scripts

ENTRYPOINT ["/usr/src/scripts/start.sh"]
