## Curator in docker

This is dockerized version of elasticsearch curator, tool to manage time-based indices.

## Why this image

This image keeps up to date with curator releases and has tags in the docker registry. It is also based on minimal alpine image,
resulting in a just 50mb image.

## Usage

- `make build` to build a specific version of curator (you will be prompted for which version from pip you want to use)
- `make build-all` will build all git-tagged versions of curator one by one
- `make push` will push a specific local docker tag of curator to dockerhub
- `make push-all` will push all local builds of curator to dockerhub

## Config

Both can be overwritten by ENV keys

- `DOCKERHUB_USER` defaults to `jippi`
- `DOCKERHUB_REPO` defaults to `elastic-curator`

### Credits

Based on the idea of `bobrik/curator`
