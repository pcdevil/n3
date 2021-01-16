export LICENSE ?= MIT

NVMRC_FILE := ${PROJECT_DIR}/.nvmrc

.PHONY: setup-license
setup-license: ## sets the license in the package.json
	$(call run_jq_on_package-json,set-license)
