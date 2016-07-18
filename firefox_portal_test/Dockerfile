FROM iotitude/firefox_env

MAINTAINER Jaakko

COPY ./scripts/ /home/root/scripts

RUN chmod -R 755 /home/root/scripts

ENTRYPOINT ["/home/root/scripts/start.sh"]
