.PHONY: b b-w l s s-w t t-w
.PHONY: build build-watch lint start start-watch test test-watch

NPM = $(shell which npm)

build: ## run the "build" npm task
build: NPM_TASK := build
build:
	$(npm-task)

b: ##  -> build
b: build

build-watch: ## run the "build:watch" npm task
build-watch: NPM_TASK := build:watch
build-watch:
	$(npm-task)

b-w: ##  -> build-watch
b-w: build-watch

lint: ## run the "lint" npm task
lint: NPM_TASK := lint
lint:
	$(npm-task)

l: ##  -> lint
l: lint

start: ## run the "start" npm task
start: NPM_TASK := start
start:
	$(npm-task)

s: ##  -> start
s: start

start-watch: ## run the "start:watch" npm task
start-watch: NPM_TASK := start:watch
start-watch:
	$(npm-task)

s-w: ##  -> start-watch
s-w: start-watch

test: ## run the "test" npm task
test: NPM_TASK := test
test:
	$(npm-task)

t: ##  -> test
t: test

test-watch: ## run the "test:watch" npm task
test-watch: NPM_TASK := test:watch
test-watch:
	$(npm-task)

t-w: ##  -> test-watch
t-w: test-watch

define npm-task =
	$(NPM) run ${NPM_TASK}
endef

define npm-install-dev-dependencies =
	$(NPM) install --save-dev ${NPM_PACKAGES}
endef
