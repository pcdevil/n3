.PHONY: setup-package-lock

setup-package-lock: ## creates a package-lock.json file
	$(eval JQ_SCRIPT_FILE := create-package-lock.jq)
	$(eval INPUT_FILE := ${PACKAGE_JSON})
	$(eval OUTPUT_FILE := ${PACKAGE_LOCK})
	$(run-jq-script-on-file)
