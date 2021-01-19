LINT_BASE_CONFIG_FILE = ${ASSETS_DIR}/eslintrc.json
LINT_CONFIGS ?= google
LINT_PLUGINS ?= jsdoc
LINT_CONFIG_FILES = $(foreach config,${LINT_CONFIGS},${ASSETS_DIR}/eslintrc.config-${config}.json)
LINT_PLUGIN_FILES = $(foreach plugin,${LINT_PLUGINS},${ASSETS_DIR}/eslintrc.plugin-${plugin}.json)
LINT_CONFIG_NPM_PACKAGES = $(foreach config,${LINT_CONFIGS},eslint-config-${config})
LINT_PLUGIN_NPM_PACKAGES = $(foreach plugin,${LINT_PLUGINS},eslint-plugin-${plugin})

.PHONY: install-lint
install-lint: ## install lint framework eslint with google rules
install-lint: .install-lint-packages .install-lint-copy-setup .install-lint-npm-tasks

.PHONY: .install-lint-packages
.install-lint-packages: NPM_PACKAGES := eslint ${LINT_CONFIG_NPM_PACKAGES} ${LINT_PLUGIN_NPM_PACKAGES}
.install-lint-packages:
	$(npm-install-dev-dependencies)

.PHONY: .install-lint-copy-setup
.install-lint-copy-setup:
	$(call run_jq,merge-lint-configs,${LINT_BASE_CONFIG_FILE} ${LINT_CONFIG_FILES} ${LINT_PLUGIN_FILES},--slurp) >${PROJECT_DIR}/.eslintrc

.PHONY: .install-lint-npm-tasks
.install-lint-npm-tasks:
	$(call run_jq_on_package-json,set-lint-task)
