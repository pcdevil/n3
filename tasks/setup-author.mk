export AUTHOR_NAME ?= $(shell git config user.name)
export AUTHOR_EMAIL ?= $(shell git config user.email)
export AUTHOR_URL ?= $(shell git config user.url)

.PHONY: setup-author
setup-author: ## sets the author in the package.json
	$(eval JQ_SCRIPT_FILE := set-author.jq)
	$(set-package-json-with-jq)
