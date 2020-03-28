.PHONY: setup-nvm

export NODE_VERSION ?= $(shell node --version)

NVMRC_FILE := ${PROJECT_DIR}/.nvmrc

setup-nvm: ## creates nvmrc file and defines the engine in the package.json
setup-nvm: JQ_SCRIPT_FILE := set-node-engine.jq
setup-nvm:
	$(set-package-json-with-jq)
	echo "${NODE_VERSION}" >${NVMRC_FILE}
