IMAGE_NAME := alexandrecarlton/bazel
BAZEL_VERSION := 0.23.0

VCS_REF := $(shell git rev-parse --short HEAD)

all: image

image: bazel-image.tar
.PHONY: image

bazel-image.tar: Dockerfile
	docker build \
		--build-arg=BAZEL_VERSION=$(BAZEL_VERSION) \
		--label org.label-schema.build-date="$(shell date --rfc-3339=seconds)" \
		--label org.label-schema.name="bazel" \
		--label org.label-schema.description="A docker image containing the Bazel build system" \
		--label org.label-schema.url="https://github.com/AlexandreCarlton/bazel-docker" \
		--label org.label-schema.vcs-url="https://github.com/AlexandreCarlton/bazel-docker" \
		--label org.label-schema.vcs-ref="$(VCS_REF)" \
		--label org.label-schema.version="$(BAZEL_VERSION)" \
		--label org.label-schema.schema-version="1.0" \
		--tag $(IMAGE_NAME):build \
		.
	docker save --output="bazel-image.tar" $(IMAGE_NAME):build

push: bazel-image.tar
	docker load --input="bazel-image.tar"
	docker tag $(IMAGE_NAME):build $(IMAGE_NAME):$(VCS_REF)
	docker tag $(IMAGE_NAME):build $(IMAGE_NAME):$(BAZEL_VERSION)
	docker push $(IMAGE_NAME):$(VCS_REF)
	docker push $(IMAGE_NAME):$(BAZEL_VERSION)
.PHONY: push
