ROOT := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
TZ := Asia/Tokyo
SLUG := some-article
PORT := 8888

.DEFAULT_GOAL := help
.PHONY := help init update article preview

all:

help:  ## show this message and exit
	@cat $(lastword $(MAKEFILE_LIST)) | awk '/^[A-Za-z]+:\s*##/ {print}'

init:  ## initalize dependally packages
	npm ci

update:  ## update dependally packages
	npm update

article:  ## make new article
	npx zenn new:article --slug "$(shell date +%Y-%2m-%2d)-$(SLUG)"
	$(EDITOR) "$(ROOT)/articles/$(shell date +%Y-%2m-%2d)-$(SLUG).md"

preview:  ## preview articles
	npx zenn preview --port $(PORT)

