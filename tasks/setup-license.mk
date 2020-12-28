export LICENSE ?= MIT

NVMRC_FILE := ${PROJECT_DIR}/.nvmrc

.PHONY: setup-license
setup-license: ## sets the license in the package.json
	$(eval JQ_SCRIPT_FILE := set-license.jq)
	$(set-package-json-with-jq)
