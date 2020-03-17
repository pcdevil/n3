.PHONY: lint start start-watch test test-watch .npm-task .npm-install-dev-dependencies

lint: ## run the "lint" npm task
lint: NPM_TASK := lint
lint: .npm-task

start: ## run the "start" npm task
start: NPM_TASK := start
start: .npm-task

start-watch: ## run the "start:watch" npm task
start-watch: NPM_TASK := start:watch
start-watch: .npm-task

test: ## run the "test" npm task
test: NPM_TASK := test
test: .npm-task

test-watch: ## run the "test:watch" npm task
test-watch: NPM_TASK := test:watch
test-watch: .npm-task

.npm-task:
	npm run ${NPM_TASK}

.npm-install-dev-dependencies:
	$(NPM) install --save-dev ${NPM_PACKAGES}
