.PHONY: install-lint
install-lint: ## install lint framework eslint with google rules
install-lint: .install-lint-packages .install-lint-copy-setup .install-lint-npm-tasks

.PHONY: .install-lint-packages
.install-lint-packages: NPM_PACKAGES := eslint eslint-config-google eslint-plugin-jsdoc
.install-lint-packages:
	$(npm-install-dev-dependencies)

.PHONY: .install-lint-copy-setup
.install-lint-copy-setup:
	$(eval JQ_SCRIPT_FILE := merge-lint-configs.jq)
	$(eval JQ_INPUT_FILES := ${ASSETS_DIR}/eslintrc.json ${ASSETS_DIR}/eslintrc.plugin-jsdoc.json)
	$(eval JQ_ARGUMENTS := --slurp)
	$(run-jq-script-on-file) >${PROJECT_DIR}/.eslintrc

.PHONY: .install-lint-npm-tasks
.install-lint-npm-tasks:
	$(eval JQ_SCRIPT_FILE := set-lint-task.jq)
	$(set-package-json-with-jq)
