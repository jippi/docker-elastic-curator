[![Docker Stars](https://img.shields.io/docker/stars/jippi/elastic-curator.svg)](https://hub.docker.com/r/jippi/elastic-curator/)
[![Docker Pulls](https://img.shields.io/docker/pulls/jippi/elastic-curator.svg)](https://hub.docker.com/r/jippi/elastic-curator/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/jippi/elastic-curator/latest.svg)](https://hub.docker.com/r/jippi/elastic-curator/)
[![ImageLayers Layers](https://img.shields.io/imagelayers/layers/jippi/elastic-curator/latest.svg)](https://hub.docker.com/r/jippi/elastic-curator/)

## Curator in docker

This is dockerized version of elasticsearch curator, tool to manage time-based indices.

## Why this image

This image keeps up to date with curator releases and has tags in the docker registry. It is also based on minimal alpine image,
resulting in a just 50mb image.

## Usage

- `make help` output instructions on how to use the Makefile
- `make build` to build a specific version of curator (you will be prompted for which version from pip you want to use)
- `make build-all` will build all git-tagged versions of curator one by one (this will *not* modify the `latest` tag)
- `make push` will push a specific local docker tag of curator to dockerhub
- `make push-all` will push all local builds of curator to dockerhub
- `make tag-latest` will build and tag the latest curator version as such

## Config

Both can be overwritten by ENV keys

- `DOCKERHUB_USER` defaults to `jippi`
- `DOCKERHUB_REPO` defaults to `elastic-curator`

### Credits

Based on the idea of `bobrik/curator`
