.PHONY: install-lint .install-lint-packages .install-lint-copy-setup .install-lint-npm-tasks

install-lint: ## install lint framework eslint with google rules
install-lint: .install-lint-packages .install-lint-copy-setup .install-lint-npm-tasks

.install-lint-packages:
	$(NPM) install --save-dev \
		eslint \
		eslint-config-google

.install-lint-copy-setup:
	cp ${ASSETS_DIR}/eslintrc.json ${PROJECT_DIR}/.eslintrc

.install-lint-npm-tasks:
.install-lint-npm-tasks: JQ_SCRIPT := .scripts.\"lint\" =
.install-lint-npm-tasks: JQ_SCRIPT += \"eslint --fix 'src/**/*.js' 'test/**/*.js'\"
.install-lint-npm-tasks: .set-package-json-with-jq
