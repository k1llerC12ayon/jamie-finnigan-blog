#!/usr/bin/env bash

set -o errexit

container=$(buildah from rust:1.55)

buildah config --label maintainer="Jamie Finnigan <k1llerC12ayon@gmail.com" $container
buildah config --workingdir /usr/src/blog $container

buildah copy $container . .
buildah run $container cargo install --path .

buildah config --entrypoint blog $container

buildah commit --format docker $container blog:latest
