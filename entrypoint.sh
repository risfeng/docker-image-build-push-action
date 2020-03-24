#!/bin/sh -l
echo $INPUT_PASSWORD | docker login --username=$INPUT_USER_NAME $INPUT_REGISTRY_URL --password-stdin
# 变量
image_name=$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
image_url=$INPUT_REGISTRY_URL/$INPUT_NAMESPACES/$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
docker_file=$INPUT_DOCKER_FILE
if [[ "${docker_file}" = "" ]]; then
    docker_file="."
fi
docker build -t ${image_name} ${docker_file}
docker tag ${image_name} ${image_url}
docker push ${image_url}

#output
echo "::set-output name=image_pull_url::${image_url}"
