#!/bin/bash
docker run --privileged --dns=8.8.8.8 --rm tonistiigi/binfmt --install all
if [ -n "$1" ]
then pushd $1
  docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag debenham/${1}:latest --tag ghcr.io/cjd/${1}:latest .
else for IMAGE in *
  do if [ -d "$IMAGE" ]
      then pushd $IMAGE
      docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag debenham/${IMAGE}:latest --tag ghcr.io/cjd/${IMAGE}:latest .
      popd
    fi
  done
fi
