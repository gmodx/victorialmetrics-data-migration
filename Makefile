VERSION_NO=1.0.0
COMMIT_ID_SHORT=$(shell git rev-parse --short HEAD)
BUILD_TIME=$(shell date "+%Y%m%d%H%M")

DOCKER_IMAGE_NAME=victorialmetrics-data-migration
DOCKER_IMAGE_TAG=$(VERSION_NO)
DOCKER_IMAGE_FULL_WITH_COMMIT_ID=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)_$(COMMIT_ID_SHORT)
DOCKER_IMAGE_FULL_LATEST=$(DOCKER_IMAGE_NAME):latest

.PHONY: img push

img:
	@echo "Building Docker image with tag..."
	docker build -f deployment/Dockerfile -t $(DOCKER_IMAGE_FULL_LATEST) -t $(DOCKER_IMAGE_FULL_WITH_COMMIT_ID) deployment/

push: img
	@echo "Pushing Docker image to registry..."
	docker push $(DOCKER_IMAGE_FULL_WITH_COMMIT_ID)
	docker push $(DOCKER_IMAGE_FULL_LATEST)
