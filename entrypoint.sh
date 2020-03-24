#!/bin/sh -l
echo "login docker start..."
echo $INPUT_PASSWORD | docker login --username=$INPUT_USER_NAME $INPUT_REGISTRY_URL --password-stdin

# 变量
image_name=$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
image_url=$INPUT_REGISTRY_URL/$INPUT_NAMESPACES/$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
docker_file=$INPUT_DOCKER_FILE
if [[ "${docker_file}" = "" ]]; then
    docker_file="."
fi

echo "docker build start..."
docker build -t ${image_name} ${docker_file}

echo "docker tag start..."
docker tag ${image_name} ${image_url}

echo "docker push start..."
docker push ${image_url}

echo "build and push success."

#output
echo "::set-output name=image_pull_url::$image_url"
