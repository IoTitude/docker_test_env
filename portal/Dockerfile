FROM node:latest
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y \

  git

RUN mkdir -p /usr/src

EXPOSE 3001
EXPOSE 3000

COPY ./scripts/ /usr/src/scripts

RUN chmod -R 755 /usr/src/scripts

ENTRYPOINT ["/usr/src/scripts/start.sh"]




