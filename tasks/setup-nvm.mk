export NODE_VERSION ?= $(shell $(NODE) --version)

NVMRC_FILE := ${PROJECT_DIR}/.nvmrc

.PHONY: setup-nvm
setup-nvm: ## creates nvmrc file and defines the engine in the package.json
	$(eval export NODE_VERSION)
	$(call run_jq_on_package-json,set-node-engine)
	echo "${NODE_VERSION}" >${NVMRC_FILE}
