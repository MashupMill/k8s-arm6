#!/usr/bin/env bash
set -e

docker build --build-arg KUBE_VERBOSE=5 --tag mashupmill/k8s-arm6 .

docker run --rm -v $(pwd)/bin:/dest mashupmill/k8s-arm6