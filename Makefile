SHELL := /bin/bash

IMAGE_NAME := dockertest_gertsev_rate
IMAGE_TAG := v1.0

CONTAINER_NAME := dockertest_gertsev_rate
CONTAINER_PORT := 5000

VOLUME_NAME := rates

build:
	@make rmi &> /dev/null || true
	@docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

run:
	@docker volume create $(VOLUME_NAME)
	@docker run --rm \
	--name $(CONTAINER_NAME) \
	-p $(CONTAINER_PORT):5000 \
	-v $(VOLUME_NAME):/rates \
	$(IMAGE_NAME):$(IMAGE_TAG)

stop:
	@docker stop $(CONTAINER_NAME)

volume-inspect:
	@docker volume inspect $(VOLUME_NAME)

volume-prune:
	@docker volume prune

rmi:
	@docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

exec:
	@docker exec -it $(CONTAINER_NAME) bash


