NPM = $(shell which npm)

.PHONY: build
build: ## run the "build" npm task
build: NPM_TASK := build
build:
	$(npm-task)

.PHONY: b
b: ##  -> build
b: build

.PHONY: build-watch
build-watch: ## run the "build:watch" npm task
build-watch: NPM_TASK := build:watch
build-watch:
	$(npm-task)

.PHONY: b-w
b-w: ##  -> build-watch
b-w: build-watch

.PHONY: lint
lint: ## run the "lint" npm task
lint: NPM_TASK := lint
lint:
	$(npm-task)

.PHONY: l
l: ##  -> lint
l: lint

.PHONY: start
start: ## run the "start" npm task
start: NPM_TASK := start
start:
	$(npm-task)

.PHONY: s
s: ##  -> start
s: start

.PHONY: start-watch
start-watch: ## run the "start:watch" npm task
start-watch: NPM_TASK := start:watch
start-watch:
	$(npm-task)

.PHONY: s-w
s-w: ##  -> start-watch
s-w: start-watch

.PHONY: test
test: ## run the "test" npm task
test: NPM_TASK := test
test:
	$(npm-task)

.PHONY: t
t: ##  -> test
t: test

.PHONY: test-watch
test-watch: ## run the "test:watch" npm task
test-watch: NPM_TASK := test:watch
test-watch:
	$(npm-task)

.PHONY: t-w
t-w: ##  -> test-watch
t-w: test-watch

define npm-task =
	$(NPM) run ${NPM_TASK}
endef

define npm-install-dev-dependencies =
	$(NPM) install --save-dev ${NPM_PACKAGES}
endef
