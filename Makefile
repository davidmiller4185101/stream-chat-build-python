STREAM_KEY ?= NOT_EXIST
STREAM_SECRET ?= NOT_EXIST

# These targets are not files
.PHONY: help check test

help: ## Display this help message
	@echo "Please use \`make <target>\` where <target> is one of"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}'

lint:  ## Run linters
	black --check stream_chat
	pycodestyle --ignore=E501,E225,W293 stream_chat

test:  ## Run tests
	STREAM_KEY=$(STREAM_KEY) STREAM_SECRET=$(STREAM_SECRET) python setup.py test

check: lint test  ## Run linters + tests
