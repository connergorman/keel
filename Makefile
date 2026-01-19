# Image URL to use all building/pushing image targets
IMG ?= keel-client:latest

# Get the currently used golang install path (in GOPATH/bin, unless GOBIN is set)
ifeq (,$(shell go env GOBIN))
GOBIN=$(shell go env GOPATH)/bin
else
GOBIN=$(shell go env GOBIN)
endif

GO_MODULE := $(shell awk '/^module / { print $$2 }' < go.mod)
# CONTAINER_TOOL defines the container tool to be used for building images.
# Be aware that the target commands are only tested with Docker which is
# scaffolded by default. However, you might want to replace it to use other
# tools. (i.e. podman)
CONTAINER_TOOL ?= docker

# Setting SHELL to bash allows bash commands to be executed by recipes.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

TARGETS := bin/keel-client bin/keel-server


PROTODIR := proto
APPLICATION_PROTO := ${PROTODIR}/application/v1/application.proto
APPLICATION_RPC := gen/application/v1/application.pb.go gen/application/v1/application_grpc.pb.go gen/application/v1/applicationv1connect/application.connect.go


.PHONY: all
all: ${TARGETS}

bin/keel-client: $(wildcard cmd/keel-client/*.go)
	go build -o $@ ${GO_MODULE}/$(subst bin,cmd,$@)

bin/keel-server: $(wildcard cmd/keel-server/*.go)
	go build -o $@ ${GO_MODULE}/$(subst bin,cmd,$@)
.PHONY: clean
clean:
	-rm ${TARGETS}
