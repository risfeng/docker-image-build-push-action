FROM alpine:latest
RUN apk add --no-cache openrc \
    && apk add docker \
    && docker -v

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
