#!/usr/bin/env bash
set -e

docker build --tag mashupmill/k8s-arm6 .

docker run --rm -v $(pwd)/bin:/dest mashupmill/k8s-arm6