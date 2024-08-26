SHELL := /bin/bash

NETWORK_NAME := docker_gertsev_net

IMAGE_NAME := docker_gertsev_rate
IMAGE_TAG := latest

CONTAINER_NAME := docker_gertsev_rate
CONTAINER_PORT := 5000

DB_VOLUME_NAME := docker_gertsev_db_volume
DB_CONTAINER_NAME := db
DB_USER := user
DB_PASSWORD := password
DB_NAME := db

VOLUME_NAME := rates

build:
	@docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

create-net:
	@docker network create $(NETWORK_NAME)

# БД
run-db:
	@docker volume create $(DB_VOLUME_NAME)
	@docker run \
	--name $(DB_CONTAINER_NAME) \
	-d \
	--net=$(NETWORK_NAME) \
	-e POSTGRES_USER=user \
	-e POSTGRES_PASSWORD=password \
	-e POSTGRES_DB=db \
	-v $(DB_VOLUME_NAME):/var/lib/postgresql/data \
	postgres:16.4-alpine

stop-db:
	@docker stop $(DB_CONTAINER_NAME)

run-app:
	@docker volume create $(VOLUME_NAME)
	@docker run \
	--name $(CONTAINER_NAME) \
	-p $(CONTAINER_PORT):5000 \
	--net=$(NETWORK_NAME) \
	-e DB_HOST=$(DB_CONTAINER_NAME) \
	-e DB_PORT=5432 \
	-e DB_USER=$(DB_USER) \
	-e DB_PASSWORD=$(DB_PASSWORD) \
	-e DB_NAME=$(DB_NAME) \
	-v $(VOLUME_NAME):/rates \
	$(IMAGE_NAME):$(IMAGE_TAG)

stop-app:
	@docker stop $(CONTAINER_NAME)

volume-inspect:
	@docker volume inspect $(VOLUME_NAME)

volume-prune:
	@docker volume prune

rm:
	@docker rm $(CONTAINER_NAME)

rm-db:
	@docker rm $(DB_CONTAINER_NAME)

rmi:
	@docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

exec:
	@docker exec -it $(CONTAINER_NAME) bash

exec-db:
	@docker exec -it $(DB_CONTAINER_NAME) bash


