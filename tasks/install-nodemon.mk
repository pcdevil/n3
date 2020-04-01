.PHONY: install-lint
.PHONY: .install-nodemon-packages .install-nodemon-copy-setup .install-nodemon-npm-tasks

install-nodemon: ## install monitoring framework nodemon
install-nodemon: .install-nodemon-packages .install-nodemon-copy-setup .install-nodemon-npm-tasks

.install-nodemon-packages: NPM_PACKAGES := nodemon
.install-nodemon-packages:
	$(npm-install-dev-dependencies)

.install-nodemon-copy-setup:
	cp ${ASSETS_DIR}/nodemon.json ${PROJECT_DIR}/.nodemonrc

.install-nodemon-npm-tasks:
	$(eval JQ_SCRIPT_FILE := set-start-watch-task.jq)
	$(set-package-json-with-jq)
