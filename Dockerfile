FROM ubuntu:latest

RUN apt-get update

RUN apt-get install sudo

COPY "entrypoint.sh" "/entrypoint.sh"

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
