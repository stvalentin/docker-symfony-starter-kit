help: ## Shows this help message.
	@echo 'usage: make [target] ...'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

install: ## Installs all dependencies
	docker-compose build
.PHONY: install

up: ## Starts all containers that must run in the background
	docker-compose up
.PHONY: up

generate: ## Generate a new empty project
	docker-compose run --rm php-fpm composer init
.PHONY: up

generate-skeleton: ## Generate a new symfony skeleton project
	docker-compose run --rm php-fpm composer create-project symfony/skeleton temp-generate-folder && cp -rp temp-generate-folder/. ./ rm && rm -r temp-generate-folder && git reset
.PHONY: up

generate-website-skeleton: ## Generate a new symfony website skeleton project
	docker-compose run --rm php-fpm composer create-project symfony/website-skeleton temp-generate-folder && cp -rp temp-generate-folder/. ./ rm && rm -r temp-generate-folder && git reset
.PHONY: up

down: ## Shut down container
	docker-compose down
.PHONY: down

build: ## Build 'build'
	docker-compose build
.PHONY: build

test: ## Runs all tests
	docker-compose run tests
.PHONY: test
