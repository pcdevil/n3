N3_MAKE := $(lastword ${MAKEFILE_LIST})
N3_DIR := $(shell dirname $(realpath ${N3_MAKE}))
ASSETS_DIR := ${N3_DIR}/assets
TASKS_DIR := ${N3_DIR}/tasks

PROJECT_DIR := ${PWD}
PACKAGE_JSON := ${PROJECT_DIR}/package.json

NODE := $(shell which node)

default: help

include ${TASKS_DIR}/install-lint.mk
include ${TASKS_DIR}/install-nodemon.mk
include ${TASKS_DIR}/install-test.mk
include ${TASKS_DIR}/npm-tasks.mk

.PHONY: help
.PHONY: .set-package-json-with-jq

help:
	@fgrep -h "##" ${MAKEFILE_LIST} | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/:.*#/: #/' | column -t -s '##'

.set-package-json-with-jq:
.set-package-json-with-jq: TEMP_FILE := $(shell mktemp)
.set-package-json-with-jq:
	jq \
		--from-file ${JQ_SCRIPT_FILE} \
		--raw-output \
		${PACKAGE_JSON} >${TEMP_FILE}
	mv ${TEMP_FILE} ${PACKAGE_JSON}
