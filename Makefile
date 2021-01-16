#!/usr/bin/make -f

N3_MAKE := $(lastword ${MAKEFILE_LIST})
N3_DIR := $(shell dirname $(realpath ${N3_MAKE}))
ASSETS_DIR := ${N3_DIR}/assets
JQ_SCRIPTS_DIR := ${N3_DIR}/jq-scripts
TASKS_DIR := ${N3_DIR}/tasks

PROJECT_DIR := ${CURDIR}
PACKAGE_JSON := ${PROJECT_DIR}/package.json
PACKAGE_LOCK := ${PROJECT_DIR}/package-lock.json

JQ = $(shell which jq)
NODE = $(shell which node)

default: help

include ${TASKS_DIR}/create-editorconfig.mk
include ${TASKS_DIR}/install-lint.mk
include ${TASKS_DIR}/install-nodemon.mk
include ${TASKS_DIR}/install-test.mk
include ${TASKS_DIR}/npm-tasks.mk
include ${TASKS_DIR}/setup-author.mk
include ${TASKS_DIR}/setup-license.mk
include ${TASKS_DIR}/setup-nvm.mk
include ${TASKS_DIR}/setup-package-lock.mk
include ${TASKS_DIR}/setup-start.mk
include ${TASKS_DIR}/sort-package-json.mk

.PHONY: help
help:
	@fgrep -h "##" ${MAKEFILE_LIST} | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/:.*#/: #/' | column -t -s '##'

.PHONY: setup
setup: ## run all setup related tasks
setup: setup-author setup-license setup-nvm setup-package-lock setup-start

# run_jq [script file] [input file] [jq arguments]
run_jq = $(JQ) \
		--from-file ${JQ_SCRIPTS_DIR}/${1}.jq \
		--raw-output \
		${3} \
		${2}

# run_jq_on_package-json [script file] [jq arguments]
run_jq_on_package-json = TEMP_FILE=$(shell mktemp); \
	$(call run_jq,${1},${PACKAGE_JSON},${2}) >$${TEMP_FILE}; \
	cat $${TEMP_FILE} >${PACKAGE_JSON}; \
	rm $${TEMP_FILE}
