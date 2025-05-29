MONGO_USER=user
MONGO_PASSWORD=password

.PHONY: help
help:
	@grep -E '^.PHONY:\s+[^#]*(##.*)?' $(MAKEFILE_LIST) | sort | cut -d ':' -f 2 | awk 'BEGIN {FS = "#"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

	@echo "============ Tips ============"
	@echo "- Add an @ before a command to stop it from being printed"
	@echo "- Add .PHONY to a target will prevent Make from confusing the phony target with a file name"
	@echo "- git rev-parse --short HEAD to get the short commit hash (7 characters)"
	@echo "=============================="

.PHONY: mongo-up # Run mongodb
mongo-up:
	@echo "***ENV for mongo-up***"
	@echo "MONGO_USER=$(MONGO_USER)" > .env
	@echo "MONGO_PASSWORD=$(MONGO_PASSWORD)" >> .env
	
	@docker compose -f ./docker-compose-mongo.yaml up -d

.PHONY: mongo-down # Stop mongodb
mongo-down:
	@docker compose -f ./docker-compose.yaml down