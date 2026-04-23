#!/bin/bash
set -e

export ARM_CLIENT_ID="$INPUT_ARM_CLIENT_ID"
export ARM_CLIENT_SECRET="$INPUT_ARM_CLIENT_SECRET"
export ARM_SUBSCRIPTION_ID="$INPUT_ARM_SUBSCRIPTION_ID"
export ARM_TENANT_ID="$INPUT_ARM_TENANT_ID"
export STATE_KEY="$INPUT_STATE_KEY"
export TF_STAGE="$INPUT_TF_STAGE"
export DJANGO_SECRET_KEY_PRD=${INPUT_DJANGO_SECRET_KEY}

echo "Running terraform for stage: $TF_STAGE"

cd "$GITHUB_WORKSPACE/$TF_STAGE"

terraform version
terraform init -backend-config="key=$STATE_KEY"
terraform validate
terraform plan 
terraform apply -auto-approve
