#!/usr/bin/env bash

set -euo pipefail

docker run --rm \
    --user $(id -u) \
    --volume ${PWD}/${TERRAFORM_DIR}:/app \
    --workdir /app \
    hashicorp/terraform:${TERRAFORM_VERSION} \
    validate
