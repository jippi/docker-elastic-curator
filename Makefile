SHELL=bash

DOCKERHUB_USER ?= jippi
DOCKERHUB_REPO ?= elastic-curator

curator/:
	git clone https://github.com/elastic/curator.git curator/

.PHONY: update-curator
update-curator: curator/
	(cd curator/ ; git pull --tags)

.PHONY: build-all
build-all: curator/ update-curator
	@set -x ; for tag in $$(cd curator/ ; git tag); do tag=$${tag#v}; docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:$$tag . --build-arg VERSION=$$tag; done

.PHONY: build
build:
	@echo ""
	@echo "Which git tag version do you want to build?"
	@echo -n "> "
	@read version ;	docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:$$version . --build-arg VERSION=$$version

.PHONY: push
push:
	@echo ""
	@echo "Which docker tag version do you want to push?"
	@echo ""
	@docker images | grep "${DOCKERHUB_USER}/${DOCKERHUB_REPO}"
	@echo ""
	@echo -n "> "
	@read version ;	docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:$$version . --build-arg VERSION=$$version

.PHONY: push-all
push-all:
	docker push ${DOCKERHUB_USER}/${DOCKERHUB_REPO}
