.PHONY: setup-start

setup-start: ## sets the start script in package.json
	$(eval JQ_SCRIPT_FILE := set-start-task.jq)
	$(set-package-json-with-jq)
