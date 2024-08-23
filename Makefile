SHELL := /bin/bash

IMAGE_NAME := docker_gertsev_rate
IMAGE_TAG := v1.2

CONTAINER_NAME := docker_gertsev_rate
CONTAINER_PORT := 5000

VOLUME_NAME := rates

build:
	@docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

run:
	@docker volume create $(VOLUME_NAME)
	@docker run \
	--name $(CONTAINER_NAME) \
	--network host \
	-p $(CONTAINER_PORT):5000 \
	-v $(VOLUME_NAME):/rates \
	$(IMAGE_NAME):$(IMAGE_TAG)

stop:
	@docker stop $(CONTAINER_NAME)

volume-inspect:
	@docker volume inspect $(VOLUME_NAME)

volume-prune:
	@docker volume prune

rm:
	@docker rm $(CONTAINER_NAME)

rmi:
	@docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

exec:
	@docker exec -it $(CONTAINER_NAME) bash


