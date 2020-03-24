FROM alpine:latest
RUN apk add docker \
    && service docker start \
    && docker -v

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
