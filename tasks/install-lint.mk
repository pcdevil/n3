.PHONY: install-lint
.PHONY: .install-lint-packages .install-lint-copy-setup .install-lint-npm-tasks

install-lint: ## install lint framework eslint with google rules
install-lint: .install-lint-packages .install-lint-copy-setup .install-lint-npm-tasks

.install-lint-packages: NPM_PACKAGES := eslint eslint-config-google eslint-plugin-jsdoc
.install-lint-packages:
	$(npm-install-dev-dependencies)

.install-lint-copy-setup:
	cp ${ASSETS_DIR}/eslintrc.json ${PROJECT_DIR}/.eslintrc

.install-lint-npm-tasks:
	$(eval JQ_SCRIPT_FILE := set-lint-task.jq)
	$(set-package-json-with-jq)
