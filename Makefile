N3_MAKE := $(lastword ${MAKEFILE_LIST})
N3_DIR := $(shell dirname $(realpath ${N3_MAKE}))

PROJECT_DIR := ${PWD}
PACKAGE_JSON := ${PROJECT_DIR}/package.json

NVM := $(shell which nvm)
NPM := $(shell which npm)
NODE := $(shell which node)

default: help

help:
	@fgrep -h "##" ${MAKEFILE_LIST} | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/:.*#/: #/' | column -t -s '##'
