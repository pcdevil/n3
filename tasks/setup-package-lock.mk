.PHONY: setup-package-lock

setup-package-lock: ## creates a package-lock.json file
setup-package-lock: JQ_SCRIPT_FILE := create-package-lock.jq
setup-package-lock: INPUT_FILE := ${PACKAGE_JSON}
setup-package-lock: OUTPUT_FILE := ${PACKAGE_LOCK}
setup-package-lock:
	$(run-jq-script-on-file)
