TZ := Asia/Tokyo
PORT := 8888

.DEFAULT_GOAL := help

.PHONY := help
help: ## Show targets in this Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | sort \
	  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY := init
init: ## Initalize dependencies packages
	npm ci

.PHONY := update
update: ## Update dependencies packages
	npm update

.PHONY := article
article: ## Create new article
	@SLUG=$(shell echo $$(read -p 'What is slug? : ' tmp ; echo $$tmp | sed -r "s/ +/-/g")) \
		&& npx zenn new:article --slug "$(shell date +%Y-%2m-%2d)-$$SLUG"

.PHONY := preview
preview: ## Preview articles and books
	npx zenn preview --port $(PORT)

.PHONY := lint
lint: ## Lint markdown files
	npx textlint articles/*.md books/*.md

.PHONY := list
list: ## List related articles and books
	@npx zenn list:articles
	@npx zenn list:books
