#!/bin/bash
ARCHS=linux/arm64/v8,linux/amd64
docker run --privileged --dns=8.8.8.8 --rm tonistiigi/binfmt --install all
if [ -n "$1" ]; then
	pushd "$1" || exit
  if [ -e .build-archs ]; then
    ARCHS=$(cat .build-archs)
  fi
  docker buildx build --push --platform "$ARCHS" --tag "debenham/${1}:latest" --tag "ghcr.io/cjd/${1}:latest" .
else
	# shellcheck disable=2013
	for D in $(grep FROM ./*/Dockerfile | cut -f2 -d" " | sort -u); do
		docker pull "$D"
	done
	for IMAGE in *; do
		if [ -d "$IMAGE" ]; then
			pushd "$IMAGE" || exit
      if [ -e .skip ]; then
        continue
      fi
      if [ -e .build-archs ]; then
        ARCHS=$(cat .build-archs)
      fi
			docker buildx build --push --platform "$ARCHS" --tag "debenham/${IMAGE}:latest" --tag "ghcr.io/cjd/${IMAGE}:latest" .
			popd || exit
		fi
	done
fi
