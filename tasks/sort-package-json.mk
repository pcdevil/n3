.PHONY: sort-package-json
sort-package-json: ## arrange package.json keys
	$(call run_jq_on_package-json,sort-package-json)
