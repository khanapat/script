POSTGRES_DB=kong
POSTGRES_USER=kong
KONG_VERSION=3.10.0.1
KONG_DATABASE=postgres
KONG_PASSWORD=bobo
KONG_ADMIN_TOKEN=8FdCSAevQFSaXdrUnFRGUG8KEZBf7N7t

.PHONY: help
help:
	@grep -E '^.PHONY:\s+[^#]*(##.*)?' $(MAKEFILE_LIST) | sort | cut -d ':' -f 2 | awk 'BEGIN {FS = "#"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

	@echo "============ Tips ============"
	@echo "- Add an @ before a command to stop it from being printed"
	@echo "- Add .PHONY to a target will prevent Make from confusing the phony target with a file name"
	@echo "- git rev-parse --short HEAD to get the short commit hash (7 characters)"
	@echo "=============================="

.PHONY: kong-db-up # Run kong gateway with database
kong-db-up:
	@echo "***ENV for kong-db-up***"
	@echo "POSTGRES_DB=$(POSTGRES_DB)" > .env
	@echo "POSTGRES_USER=$(POSTGRES_USER)" >> .env
	@echo "KONG_VERSION=$(KONG_VERSION)" >> .env
	@echo "KONG_DATABASE=$(KONG_DATABASE)" >> .env
	@echo "KONG_PASSWORD=$(KONG_PASSWORD)" >> .env

	@docker compose -f ./docker-compose-kong-db.yaml up -d

.PHONY: kong-db-down # Stop kong gateway with database
kong-db-down: 
	@docker compose -f ./docker-compose-kong-db.yaml down

.PHONY: kong-dbless-up # Run kong gateway without database
kong-dbless-up:
	@echo "KONG_VERSION=$(KONG_VERSION)" > .env

	@docker compose -f ./docker-compose-kong-dbless.yaml up -d

.PHONY: kong-dbless-down # Stop kong gateway without database
kong-dbless-down:
	@docker compose -f ./docker-compose-kong-dbless.yaml down