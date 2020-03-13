#!/usr/bin/env bash

set -euo pipefail

docker run --rm \
    --user $(id -u) \
    --env AWS_ACCESS_KEY_ID \
    --env AWS_SECRET_ACCESS_KEY \
    --env TF_VAR_aws_region=${AWS_DEFAULT_REGION} \
    --volume ${PWD}/${TERRAFORM_DIR}:/app \
    --workdir /app \
    hashicorp/terraform:${TERRAFORM_VERSION} \
    apply -auto-approve tf_plan
