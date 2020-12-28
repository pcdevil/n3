export NODE_VERSION ?= $(shell $(NODE) --version)

NVMRC_FILE := ${PROJECT_DIR}/.nvmrc

.PHONY: setup-nvm
setup-nvm: ## creates nvmrc file and defines the engine in the package.json
	$(eval JQ_SCRIPT_FILE := set-node-engine.jq)
	$(eval export NODE_VERSION)
	$(set-package-json-with-jq)
	echo "${NODE_VERSION}" >${NVMRC_FILE}
