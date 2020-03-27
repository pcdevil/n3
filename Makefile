N3_MAKE := $(lastword ${MAKEFILE_LIST})
N3_DIR := $(shell dirname $(realpath ${N3_MAKE}))
ASSETS_DIR := ${N3_DIR}/assets
JQ_SCRIPTS_DIR := ${N3_DIR}/jq-scripts
TASKS_DIR := ${N3_DIR}/tasks

PROJECT_DIR := ${PWD}
PACKAGE_JSON := ${PROJECT_DIR}/package.json
PACKAGE_LOCK := ${PROJECT_DIR}/package-lock.json

NODE := $(shell which node)

default: help

include ${TASKS_DIR}/install-lint.mk
include ${TASKS_DIR}/install-nodemon.mk
include ${TASKS_DIR}/install-test.mk
include ${TASKS_DIR}/npm-tasks.mk
include ${TASKS_DIR}/setup-author.mk
include ${TASKS_DIR}/setup-license.mk
include ${TASKS_DIR}/setup-nvm.mk
include ${TASKS_DIR}/setup-package-lock.mk

.PHONY: help
.PHONY: .run-jq-script-on-file .set-package-json-with-jq

help:
	@fgrep -h "##" ${MAKEFILE_LIST} | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/:.*#/: #/' | column -t -s '##'

.run-jq-script-on-file:
	jq \
		--from-file ${JQ_SCRIPTS_DIR}/${JQ_SCRIPT_FILE} \
		--raw-output \
		${INPUT_FILE} >${OUTPUT_FILE}

.set-package-json-with-jq:
.set-package-json-with-jq: INPUT_FILE := ${PACKAGE_JSON}
.set-package-json-with-jq: OUTPUT_FILE := $(shell mktemp)
.set-package-json-with-jq: .run-jq-script-on-file
	mv ${OUTPUT_FILE} ${INPUT_FILE}
