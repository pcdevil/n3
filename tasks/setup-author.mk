.PHONY: setup-author

export AUTHOR_NAME ?= $(shell git config user.name)
export AUTHOR_EMAIL ?= $(shell git config user.email)
export AUTHOR_URL ?= $(shell git config user.url)

setup-author: ## sets the author in the package.json
setup-author: JQ_SCRIPT_FILE := set-author.jq
setup-author:
	$(set-package-json-with-jq)
