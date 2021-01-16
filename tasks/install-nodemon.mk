.PHONY: install-nodemon
install-nodemon: ## install monitoring framework nodemon
install-nodemon: .install-nodemon-packages .install-nodemon-copy-setup .install-nodemon-npm-tasks

.PHONY: .install-nodemon-packages
.install-nodemon-packages: NPM_PACKAGES := nodemon
.install-nodemon-packages:
	$(npm-install-dev-dependencies)

.PHONY: .install-nodemon-copy-setup
.install-nodemon-copy-setup:
	cp ${ASSETS_DIR}/nodemon.json ${PROJECT_DIR}/.nodemonrc

.PHONY: .install-nodemon-npm-tasks
.install-nodemon-npm-tasks:
	$(call run_jq_on_package-json,set-start-watch-task)
