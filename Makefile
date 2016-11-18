SHELL := /bin/bash

.DEFAULT_GOAL := help

DOCKERHUB_USER ?= jippi
DOCKERHUB_REPO ?= elastic-curator

curator/:
	git clone https://github.com/elastic/curator.git curator/

.PHONY: update-curator
update-curator: curator/
	@(cd curator/ ; git pull --tags)

.PHONY: build-all
build-all: curator/ update-curator ## build all curator git tags into docker
	@set -x ; for tag in $$(cd curator/ ; git tag); do tag=$${tag#v}; \
		docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:$$tag . --build-arg VERSION=$$tag; \
	done

.PHONY: tag-latest
tag-latest: curator/ update-curator ## build and tag "latest"
	@set -x ; latest=$$(cd curator ; git tag | sort | tail -1); \
		tag=$${latest#v}; \
		docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:latest . --build-arg VERSION=$$tag
#		docker push ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:latest ; \
#		docker push ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:$$tag

.PHONY: build
build: ## build a specific version of curator
	@echo ""
	@echo "Which git tag version do you want to build?"
	@echo -n "> "
	@read version ;	docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:$$version . --build-arg VERSION=$$version

.PHONY: push
push: ## push a specific version of curator
	@echo ""
	@echo "Which docker tag do you want to push?"
	@echo ""
	@docker images | grep "${DOCKERHUB_USER}/${DOCKERHUB_REPO}"
	@echo ""
	@echo -n "> "
	@read version ;	docker push ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:$$version

.PHONY: push-all
push-all: ## push all local versions of curator to remote dockerhub
	docker push ${DOCKERHUB_USER}/${DOCKERHUB_REPO}

.PHONY: list-local-docker-tags
list-local-docker-tags: ## list local docker tags
	@echo ""
	@echo "Available local docker tags"
	@echo ""
	@docker images | grep "${DOCKERHUB_USER}/${DOCKERHUB_REPO}"

.PHONY: list-remote-docker-tags
list-remote-docker-tags: ## list remote docker tags
	@echo ""
	@echo "Available remote docker tags"
	@echo ""
	@wget -q https://registry.hub.docker.com/v1/repositories/${DOCKERHUB_USER}/${DOCKERHUB_REPO}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $$3}'

.PHONY: dist-clean-images
dist-clean-images: ## remove all local docker image tags
	docker rmi "${DOCKERHUB_USER}/${DOCKERHUB_REPO}"
	docker rmi $$(docker images | grep "${DOCKERHUB_USER}/${DOCKERHUB_REPO}" | awk '{print $$3}')

.PHONY: run
run: ## run curator
	docker run -it --rm ${DOCKERHUB_USER}/${DOCKERHUB_REPO}

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
