TEST_FRAMEWORK ?= mocha

ifeq (${TEST_FRAMEWORK},ava)
TEST_JQ_SCRIPT_FILE = set-test-task-ava
TEST_NPM_PACKAGES = ava
TEST_SUB_TASKS = .install-test-copy-ava-config
endif

ifeq (${TEST_FRAMEWORK},mocha)
TEST_JQ_SCRIPT_FILE = set-test-task-mocha
TEST_NPM_PACKAGES = chai mocha sinon sinon-chai
TEST_SUB_TASKS = .install-test-copy-mocha-setup
endif

.PHONY: install-test
install-test: ## install test framework mocha with chai and sinon included
install-test: .install-test-packages .install-test-create-test-folder .install-test-npm-tasks
install-test: ${TEST_SUB_TASKS}

.PHONY: .install-test-packages
.install-test-packages: NPM_PACKAGES := ${TEST_NPM_PACKAGES}
.install-test-packages:
	$(npm-install-dev-dependencies)

.PHONY: .install-test-create-test-folder
.install-test-create-test-folder:
	mkdir --parents ${PROJECT_DIR}/test

.PHONY: .install-test-copy-mocha-setup
.install-test-copy-mocha-setup:
	cp ${ASSETS_DIR}/mocha-setup.js ${PROJECT_DIR}/test/setup.js

.PHONY: .install-test-copy-ava-config
.install-test-copy-ava-config:
	cp ${ASSETS_DIR}/ava.config.js ${PROJECT_DIR}

.PHONY: .install-test-npm-tasks
.install-test-npm-tasks:
	$(call run_jq_on_package-json,${TEST_JQ_SCRIPT_FILE})
