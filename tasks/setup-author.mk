export AUTHOR_NAME ?= $(shell git config user.name)
export AUTHOR_EMAIL ?= $(shell git config user.email)
export AUTHOR_URL ?= $(shell git config user.url)

.PHONY: setup-author
setup-author: ## sets the author in the package.json
	$(call run_jq_on_package-json,set-author)
