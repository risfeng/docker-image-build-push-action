FROM docker:19.03.2
LABEL "com.github.actions.name"="Aliyun Docker Images Build And Push"
LABEL "com.github.actions.description"="GitHub Action For Aliyun Docker Hub Image Build And Push"
LABEL "com.github.actions.icon"="anchor"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/risfeng/aliyun-docker-image-build-push-action"
LABEL "maintainer"="risfeng@gmail.com"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache git

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]