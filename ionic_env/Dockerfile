FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \

  curl git wget unzip

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

RUN apt-get update && apt-get install -y \

  nodejs

RUN npm install -g cordova ionic

RUN mkdir -p /usr/src

WORKDIR /usr/src

RUN wget https://github.com/IoTitude/Instapp/archive/v0.2.zip

RUN unzip v0.2.zip

WORKDIR /usr/src/Instapp-0.2

EXPOSE 8100

CMD ["ionic", "serve", "--all", "--nobrowser", "--nolivereload", "--port=8100", "&"]


# Commands for running

# docker run -dt -p 8100:8100 --name=instapp instapp

# docker run -di -p 8100:8100 --name=instapp instapp

# ionic serve --all --nobrowser --nolivereload --port=8100


