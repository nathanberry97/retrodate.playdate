.DEFAULT_GOAL := explain

SIM="Playdate Simulator"

.PHONY: explain
explain:
	@echo retrodate.playdate
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: build
build: src ## Build the project
	@mkdir -p build
	@pdc src build/retrodate.pdx

.PHONY: clean
clean: ## Clean the project
	@rm -rf build/retrodate.pdx

.PHONY: run
run: build ## Run the project
	@$(PLAYDATE_SDK_PATH)/bin/$(SIM).app/Contents/MacOS/$(SIM) build/retrodate.pdx
