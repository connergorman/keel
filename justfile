KUBECTL := "kubectl --kubeconfig local/kubeconfig"
DOCKER := `which docker || which podman`
KUSTOMIZE := "kustomize"

# Build and check everything
build: check
    make all

build-images:
    #!/bin/bash
    {{ DOCKER }} build -t keel-client:latest -f cmd/keel-client/Dockerfile .
    {{ DOCKER }} build -t keel-client:latest -f cmd/keel-server/Dockerfile .

check:
    go vet ./...
    go fmt ./...
    go tool staticcheck ./...

create-kind-cluster:
    kind create cluster --name keel --kubeconfig local/kubeconfig

destroy-kind-cluster:
    kind delete cluster --name keel

install:
    {{ KUSTOMIZE }} build --enable-helm deploy/overlays/dev | kubectl apply -f -
    {{ KUBECTL }} rollout restart -n keel deployment keel-client

deploy: build-images && install
    kind -n keel load docker-image keel-client:latest
    kind -n keel load docker-image keel-server:latest

devshell $KUBECONFIG="local/kubeconfig":
    exec $SHELL
