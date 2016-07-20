FROM ubuntu:14.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y \

  curl git wget unzip screen expect

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

RUN apt-get update && apt-get install -y \

  nodejs

RUN npm install -g cordova ionic gulp

RUN mkdir -p /usr/src

EXPOSE 8100

COPY ./scripts/ /usr/src/scripts

RUN chmod -R 755 /usr/src/scripts

CMD ["/usr/src/scripts/start.sh"]

# CMD ["ionic", "serve", "--all", "--nobrowser", "--nolivereload", "--port=8100", "&"]

# Commands for running

# docker run -dt -p 8100:8100 --name=instapp instapp

# docker run -di -p 8100:8100 --name=instapp instapp

# ionic serve --all --nobrowser --nolivereload --port=8100
