.PHONY: setup-start

setup-start: ## sets the start script in package.json
setup-start: JQ_SCRIPT_FILE := set-start-task.jq
setup-start:
	$(set-package-json-with-jq)
