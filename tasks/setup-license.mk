.PHONY: setup-license

export LICENSE ?= MIT

NVMRC_FILE := ${PROJECT_DIR}/.nvmrc

setup-license: ## sets the license in the package.json
setup-license: JQ_SCRIPT_FILE := ${N3_DIR}/jq-scripts/set-license.jq
setup-license: .set-package-json-with-jq
