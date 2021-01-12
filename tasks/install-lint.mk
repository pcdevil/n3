LINT_BASE_CONFIG_FILE = ${ASSETS_DIR}/eslintrc.json
LINT_PLUGINS ?= jsdoc
LINT_PLUGIN_FILES = $(foreach plugin,${LINT_PLUGINS},${ASSETS_DIR}/eslintrc.plugin-${plugin}.json)
LINT_PLUGIN_PACKAGES = $(foreach plugin,${LINT_PLUGINS},eslint-plugin-${plugin})

.PHONY: install-lint
install-lint: ## install lint framework eslint with google rules
install-lint: .install-lint-packages .install-lint-copy-setup .install-lint-npm-tasks

.PHONY: .install-lint-packages
.install-lint-packages: NPM_PACKAGES := eslint eslint-config-google ${LINT_PLUGIN_PACKAGES}
.install-lint-packages:
	$(npm-install-dev-dependencies)

.PHONY: .install-lint-copy-setup
.install-lint-copy-setup:
	$(eval JQ_SCRIPT_FILE := merge-lint-configs.jq)
	$(eval JQ_INPUT_FILES := ${LINT_BASE_CONFIG_FILE} ${LINT_PLUGIN_FILES})
	$(eval JQ_ARGUMENTS := --slurp)
	$(run-jq-script-on-file) >${PROJECT_DIR}/.eslintrc

.PHONY: .install-lint-npm-tasks
.install-lint-npm-tasks:
	$(eval JQ_SCRIPT_FILE := set-lint-task.jq)
	$(set-package-json-with-jq)
