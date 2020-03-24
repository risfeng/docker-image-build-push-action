#!/bin/sh -l
echo "login docker start..."
echo $INPUT_PASSWORD | docker login --username=$INPUT_USER_NAME $INPUT_REGISTRY_URL --password-stdin
echo "docker build start..."
docker_file=$INPUT_DOCKER_FILE
if [ "${docker_file}" = "" ]; then
    docker_file="."
fi
docker build -t $INPUT_IMAGE_NAME:$INPUT_IMAGE_VERSION ${docker_file}
echo "docker tag start..."
docker tag $INPUT_IMAGE_NAME:$INPUT_IMAGE_VERSION $INPUT_REGISTRY_URL/$INPUT_NAMESPACES/$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
echo "docker push start..."
docker push $INPUT_REGISTRY_URL/$INPUT_NAMESPACES/$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION
echo "build build and push success."
echo "docker logout..."
docker logout
echo "参数： $INPUT_USER_NAME  ${docker_file}  $INPUT_REGISTRY_URL  $INPUT_IMAGE_NAME:$INPUT_IMAGE_VERSION $INPUT_REGISTRY_URL/$INPUT_NAMESPACES/$INPUT_REPOSITORY_NAME:$INPUT_IMAGE_VERSION"