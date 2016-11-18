# Usage:

- `make build` to build a specific version of curator (you will be prompted for which version from pip you want to use)
- `make build-all` will build all git-tagged versions of curator one by one
- `make push` will push a specific local docker tag of curator to dockerhub
- `make push-all` will push all local builds of curator to dockerhub

# Config:

Both can be overwritten by ENV keys

- `DOCKERHUB_USER` defaults to `jippi`
- `DOCKERHUB_REPO` defaults to `elastic-curator`
