N3_MAKE := $(lastword ${MAKEFILE_LIST})
N3_DIR := $(shell dirname $(realpath ${N3_MAKE}))
ASSETS_DIR := ${N3_DIR}/assets
TASKS_DIR := ${N3_DIR}/tasks

PROJECT_DIR := ${PWD}
PACKAGE_JSON := ${PROJECT_DIR}/package.json

NVM := $(shell which nvm)
NPM := $(shell which npm)
NODE := $(shell which node)

default: help

include ${TASKS_DIR}/install-test.mk

.PHONY: help .set-package-json-with-jq

help:
	@fgrep -h "##" ${MAKEFILE_LIST} | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/:.*#/: #/' | column -t -s '##'

.set-package-json-with-jq:
.set-package-json-with-jq: TEMP_FILE := $(shell mktemp)
.set-package-json-with-jq:
	cp ${PACKAGE_JSON} ${TEMP_FILE}
	jq --raw-output "${JQ_SCRIPT}" ${TEMP_FILE} >${PACKAGE_JSON}
	rm ${TEMP_FILE}
