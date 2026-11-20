#!/bin/bash
set -uo pipefail

DEFAULT_ARCHS="linux/arm64/v8,linux/amd64"
TAG=$(date "+%Y.%m.%d")
PUSH_FLAG="--push"
TARGET=""

for arg in "$@"; do
  case "$arg" in
    --no-push)
      PUSH_FLAG=""
      ;;
    -h|--help)
      echo "Usage: $0 [--no-push] [directory]"
      exit 0
      ;;
    *)
      TARGET="${arg%/}"
      ;;
  esac
done

ensure_binfmt() {
  if [ ! -e /proc/sys/fs/binfmt_misc/qemu-aarch64 ]; then
    docker run --privileged --dns=8.8.8.8 --rm tonistiigi/binfmt --install all || return 1
  fi
}

build_image() {
  local image="${1%/}"
  local archs="$DEFAULT_ARCHS"

  if [ ! -f "$image/Dockerfile" ]; then
    echo "Error: $image/Dockerfile not found" >&2
    return 1
  fi

  if [ -e "$image/.build-archs" ]; then
    archs=$(<"$image/.build-archs")
  fi

  echo "=== Building $image ($archs) ==="
  docker buildx build \
    --pull \
    ${PUSH_FLAG:+"$PUSH_FLAG"} \
    --platform "$archs" \
    --tag "debenham/${image}:${TAG}" \
    --tag "ghcr.io/cjd/${image}:${TAG}" \
    --tag "debenham/${image}:latest" \
    --tag "ghcr.io/cjd/${image}:latest" \
    "$image"
}

ensure_binfmt || exit 1

if [ -n "$TARGET" ]; then
  build_image "$TARGET"
  exit $?
fi

failed=()
for dir in */; do
  image="${dir%/}"
  [ -f "$image/Dockerfile" ] || continue
  if [ -e "$image/.skip" ]; then
    echo "=== Skipping $image (.skip present) ==="
    continue
  fi
  if ! build_image "$image"; then
    failed+=("$image")
  fi
done

if [ ${#failed[@]} -gt 0 ]; then
  echo "Failed images: ${failed[*]}" >&2
  exit 1
fi
