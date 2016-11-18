SHELL=bash

curator/:
	git clone https://github.com/elastic/curator.git curator/

update-curator: curator/
	(cd curator/ ; git pull --tags)

build-all: curator/ update-curator
	@for tag in $$(cd curator/ ; git tag); do docker build -t bownty/elasticsearch-curator:$tag . --build-arg VERSION=$$tag; done

build:
	@echo ""
	@echo "Which git tag version do you want to build?"
	@echo -n "> "
	@read version ;	docker build -t bownty/elasticsearch-curator:$$version . --build-arg VERSION=$$version

push:
	docker push bownty/elasticsearch-curator
