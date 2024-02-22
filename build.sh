#!/bin/bash
#ARCHS=linux/arm/v7,linux/arm64/v8,linux/amd64
ARCHS=linux/arm64/v8,linux/amd64
# shellcheck disable=2013
docker run --privileged --dns=8.8.8.8 --rm tonistiigi/binfmt --install all
if [ -n "$1" ]; then
	pushd "$1" || exit
  docker buildx build --push --platform "$ARCHS" --tag "debenham/${1}:latest" --tag "ghcr.io/cjd/${1}:latest" .
else
	for D in $(grep FROM ./*/Dockerfile | cut -f2 -d" " | sort -u); do
		docker pull "$D"
	done
	for IMAGE in *; do
		if [ -d "$IMAGE" ]; then
			pushd "$IMAGE" || exit
			docker buildx build --push --platform "$ARCHS" --tag "debenham/${IMAGE}:latest" --tag "ghcr.io/cjd/${IMAGE}:latest" .
			popd || exit
		fi
	done
fi
