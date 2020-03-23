FROM ubuntu:latest

RUN sudo apt-get update

COPY "entrypoint.sh" "/entrypoint.sh"

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
