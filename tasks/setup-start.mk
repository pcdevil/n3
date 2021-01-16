.PHONY: setup-start
setup-start: ## sets the start script in package.json
	$(call run_jq_on_package-json,set-start-task)
