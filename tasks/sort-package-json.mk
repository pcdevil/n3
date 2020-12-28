.PHONY: sort-package-json
sort-package-json: ## arrange package.json keys
	$(eval JQ_SCRIPT_FILE := sort-package-json.jq)
	$(set-package-json-with-jq)
