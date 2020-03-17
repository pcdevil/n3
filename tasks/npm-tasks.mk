.PHONY: l s s-w t t-w
.PHONY: lint start start-watch test test-watch
.PHONY: .npm-task .npm-install-dev-dependencies

l: ##  -> lint
l: lint

lint: ## run the "lint" npm task
lint: NPM_TASK := lint
lint: .npm-task

s: ##  -> start
s: start

start: ## run the "start" npm task
start: NPM_TASK := start
start: .npm-task

s-w: ##  -> start-watch
s-w: start-watch

start-watch: ## run the "start:watch" npm task
start-watch: NPM_TASK := start:watch
start-watch: .npm-task

t: ##  -> test
t: test

test: ## run the "test" npm task
test: NPM_TASK := test
test: .npm-task

t-w: ##  -> test-watch
t-w: test-watch

test-watch: ## run the "test:watch" npm task
test-watch: NPM_TASK := test:watch
test-watch: .npm-task

.npm-task:
	npm run ${NPM_TASK}

.npm-install-dev-dependencies:
	$(NPM) install --save-dev ${NPM_PACKAGES}
