IBFT_CONFIG_FILE_NAME = ibftConfigFile.json
IBFT_EXIST = $(wildcard $(IBFT_CONFIG_FILE_NAME))

CONTAINERNAME = besunode
CONTAINER_EXIST = $(shell docker images -q $(CONTAINERNAME) 2> /dev/null)

KEYS_DIRECTORY = $(sort $(dir $(wildcard networkFiles/keys/*/)))

VNODE1DIR = $(word 1,$(KEYS_DIRECTORY))
VNODE2DIR = $(word 2,$(KEYS_DIRECTORY))
VNODE3DIR = $(word 3,$(KEYS_DIRECTORY))
VNODE4DIR = $(word 4,$(KEYS_DIRECTORY))

BNODE1DIR = $(word 5,$(KEYS_DIRECTORY))

VNODE1_ADDR = $(subst /,,$(subst networkFiles/keys/0x,,$(VNODE1DIR)))
VNODE2_ADDR = $(subst /,,$(subst networkFiles/keys/0x,,$(VNODE2DIR)))
VNODE3_ADDR = $(subst /,,$(subst networkFiles/keys/0x,,$(VNODE3DIR)))
VNODE4_ADDR = $(subst /,,$(subst networkFiles/keys/0x,,$(VNODE4DIR)))

BNODE1_ADDR = $(subst /,,$(subst networkFiles/keys/0x,,$(BNODE1DIR)))

VALNODE1_ADDR = 127.0.0.1
VALNODE1_ENODE = "enode://$(subst 0x,,$(shell cat $(VNODE1DIR)key.pub))@$(VALNODE1_ADDR):30303"
VALNODE2_ADDR = 127.0.0.1
VALNODE2_ENODE = "enode://$(subst 0x,,$(shell cat $(VNODE2DIR)key.pub))@$(VALNODE2_ADDR):30303"
VALNODE3_ADDR = 127.0.0.1
VALNODE3_ENODE = "enode://$(subst 0x,,$(shell cat $(VNODE3DIR)key.pub))@$(VALNODE3_ADDR):30303"
VALNODE4_ADDR = 127.0.0.1
VALNODE4_ENODE = "enode://$(subst 0x,,$(shell cat $(VNODE4DIR)key.pub))@$(VALNODE4_ADDR):30303"

BOOTNODE1_ADDR = 127.0.0.1
BOOTNODE1_ENODE = "enode://$(subst 0x,,$(shell cat $(BNODE1DIR)key.pub))@$(BOOTNODE1_ADDR):30303"

new-genesis:
ifeq ($(IBFT_EXIST), $(IBFT_CONFIG_FILE_NAME))
	@rm -rf networkFiles
	@besu operator generate-blockchain-config --config-file=$(IBFT_CONFIG_FILE_NAME) --to=networkFiles --private-key-file-name=key
	@make info
else
	@echo "==> IBFT CONFIG NOT EXIST NOOB!!!"
endif

gen-validator:
	@echo "==> NETWORK FILE GENERATED"
	@echo "==> removing old defaultValidator.json"
	@rm -rf defaultValidator.json
	@echo "[" >> defaultValidator.json
	@echo "\"$(VNODE1_ADDR)\"," >> defaultValidator.json
	@echo "\"$(VNODE2_ADDR)\"," >> defaultValidator.json
	@echo "\"$(VNODE3_ADDR)\"," >> defaultValidator.json
	@echo "\"$(VNODE4_ADDR)\"" >> defaultValidator.json
	@echo "]" >> defaultValidator.json
	@echo "==> append new defaultValidator.json"
	@make replace-genesis

replace-genesis:
	@echo "==> surgery genesis with new validator 1-4 into networkFiles/genesis.json"
	@jq '.extraData="$(shell besu rlp encode --from=defaultValidator.json)"' networkFiles/genesis.json > networkFiles/tmpGenesis.json && mv networkFiles/tmpGenesis.json networkFiles/genesis.json

gen-staticnode:
	@rm -rf static-nodes.json
	@echo "[" >> static-nodes.json
	@echo "\"$(VALNODE1_ENODE)\"," >> static-nodes.json
	@echo "\"$(VALNODE2_ENODE)\"," >> static-nodes.json
	@echo "\"$(VALNODE3_ENODE)\"," >> static-nodes.json
	@echo "\"$(VALNODE4_ENODE)\"," >> static-nodes.json
	@echo "\"$(BOOTNODE1_ENODE)\"" >> static-nodes.json
	@echo "]" >> static-nodes.json

val1:
ifneq ($(CONTAINER_EXIST),)
	@echo "==> $(CONTAINERNAME) was found"
	@echo "==> Removing existing node"
endif
	@echo $(CONTAINER_EXIST)
	@echo $()
	@echo "==> Preparing mount folder & configs"


info:
	@echo "  "
	@echo " =============================================================== "
	@echo " = command list ================================================ "
	@echo " make new-genesis    :generate genesis from ibftConfigFile.json	"
	@echo " make gen-validator	:generate defaultValidator.json				"
	@echo " make gen-staticnode	:generate default static nodes				"
	@echo " make info           :get all of information in makefile			"

test:
	@echo "$(word 1, $(sort $(dir $(wildcard networkFiles/keys/*/))))"
	@echo "$(word 2, $(sort $(dir $(wildcard networkFiles/keys/*/))))"

	@echo "$(subst networkFiles/keys/0x,,$(word 2, $(sort $(dir $(wildcard networkFiles/keys/*/)))))"
	@echo "$(subst /,,$(subst networkFiles/keys/0x,,$(word 2, $(sort $(dir $(wildcard networkFiles/keys/*/))))))"

	@echo "-------"

	@echo $(BNODE1)
	@echo "$(shell cat $(BNODE1)key.pub)"

	@echo "-------"

	@echo $(shell besu rlp encode --from=defaultValidator.json)

	@echo "-------"

	@echo $(VNODE1DIR)
	@echo $(VNODE1_ADDR)

	@echo "-------"

	@echo $(shell docker ps -a --filter "name=besu" | grep besu | wc -l)
	@echo $(shell docker inspect --format="{{.State.Running}}" postgres)
	@echo $(shell docker ps -a --filter "name=$(CONTAINERNAME)" | grep $(CONTAINERNAME) | wc -l)

# wildcard - get file name
# dir - get path (ex. ./ src/)
# sort - order list and remove duplicate
# word - nth word of list

# jq - get json file cli // https://tecadmin.net/linux-jq-command/#:~:text=The%20JQ%20command%20is%20used,data%20from%20a%20JSON%20file.

# ifeq ("$(IBFT_EXIST)","true")
# 	@echo "bobo"
# else
# 	@echo "noob"