PREFIX_NO_SERVICES_ENV_PATH=no-service
PREFIX_SERVICES_ENV_PATH=service
BACKEND_BLOCKSCOUT_VERSION=v7.0.2

.PHONY: help
help:
	@grep -E '^.PHONY:\s+[^#]*(##.*)?' $(MAKEFILE_LIST) | sort | cut -d ':' -f 2 | awk 'BEGIN {FS = "#"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

	@echo "============ Tips ============"
	@echo "- Add an @ before a command to stop it from being printed"
	@echo "- Add .PHONY to a target will prevent Make from confusing the phony target with a file name"
	@echo "- git rev-parse --short HEAD to get the short commit hash (7 characters)"
	@echo "=============================="

.PHONY: blockscout-no-service-up # Run blockscout without microservices
blockscout-no-service-up:
	@echo "***ENV for blockscout-no-service-up***"
	@echo "PREFIX_ENV_PATH=$(PREFIX_NO_SERVICES_ENV_PATH)" > .env

	@BLOCKSCOUT_VERSION=$(BACKEND_BLOCKSCOUT_VERSION) docker compose -f ./docker-compose-no-services.yaml up -d

.PHONY: blockscout-no-service-down # Stop blockscout without microservices
blockscout-no-service-down:
	@docker compose -f ./docker-compose-no-services.yaml down &> /dev/null

.PHONY: blockscout-service-up # Run blockscout with microservices
blockscout-service-up:
	@echo "***ENV for blockscout-service-up***"
	@echo "PREFIX_ENV_PATH=$(PREFIX_SERVICES_ENV_PATH)" > .env

	@BLOCKSCOUT_VERSION=$(BACKEND_BLOCKSCOUT_VERSION) docker compose -f ./docker-compose-microservices.yaml up -d

.PHONY: blockscout-service-down # Stop blockscout with microservices
blockscout-service-down:
	@docker compose -f ./docker-compose-microservices.yaml down &> /dev/null

.PHONY: clear # Clear blockscout data
clear:
	@rm -rf ./services/blockscout-db-data ./services/dets ./services/logs ./services/redis-data ./services/proxy/explorer.conf.template