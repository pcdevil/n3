.PHONY: install-test
.PHONY: .install-test-packages .install-test-copy-setup .install-test-npm-tasks

install-test: ## install test framework mocha with chai and sinon included
install-test: .install-test-packages .install-test-copy-setup .install-test-npm-tasks

.install-test-packages: NPM_PACKAGES := chai mocha sinon sinon-chai
.install-test-packages:
	$(npm-install-dev-dependencies)

.install-test-copy-setup:
	mkdir --parents ${PROJECT_DIR}/test
	cp ${ASSETS_DIR}/mocha-setup.js ${PROJECT_DIR}/test/setup.js

.install-test-npm-tasks:
	$(eval JQ_SCRIPT_FILE := set-test-task.jq)
	$(set-package-json-with-jq)
