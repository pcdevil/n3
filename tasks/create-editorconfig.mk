.PHONY: create-editorconfig
create-editorconfig: ## create an editorconfig file for the project
	cp ${ASSETS_DIR}/editorconfig.ini ${PROJECT_DIR}/.editorconfig
