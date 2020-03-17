.PHONY: install-test
.PHONY: .install-test-packages .install-test-copy-setup .install-test-npm-tasks

install-test: ## install test framework mocha with chai and sinon included
install-test: .install-test-packages .install-test-copy-setup .install-test-npm-tasks

.install-test-packages: NPM_PACKAGES := chai mocha sinon sinon-chai
.install-test-packages: .npm-install-dev-dependencies

.install-test-copy-setup:
	mkdir --parents ${PROJECT_DIR}/test
	cp ${ASSETS_DIR}/mocha-setup.js ${PROJECT_DIR}/test/setup.js

.install-test-npm-tasks:
.install-test-npm-tasks: JQ_SCRIPT := .scripts.\"test\" =
.install-test-npm-tasks: JQ_SCRIPT += \"mocha 'test/setup.js' 'test/**/*.spec.js'\"
.install-test-npm-tasks: JQ_SCRIPT += | .scripts.\"test:watch\" =
.install-test-npm-tasks: JQ_SCRIPT += \"npm run test -- --watch --reporter min\"
.install-test-npm-tasks: .set-package-json-with-jq
