#!/bin/bash
set -e


echo
function cleanup {
    status=$?; 
    if [ $status != 0 ] && [ -f error.txt ]; then echo "Failure: $status" && python3 script/send_to_cw.py error.txt; fi
}

trap cleanup EXIT

terraform -v
aws ssm get-parameters --name "${AWS_PARAM_STORE_TF_BACKEND_KEY}" --with-decryption --query "Parameters[*].Value" --output text > backend.conf 2> error.txt
aws ssm get-parameters --name "${AWS_PARAM_STORE_TF_VARS_KEY}" --with-decryption --query "Parameters[*].Value" --output text > terraform.tfvars 2> error.txt
terraform init -backend-config=backend.conf -reconfigure > /dev/null 2> error.txt
terraform workspace list
terraform workspace select "${ENV}"
terraform plan -var " ${TF_VAR_TERRAFORM_ASSUME_ROLES}" -var-file="terraform.tfvars" -input=false -out plan.out > /dev/null 2> error.txt
terraform show -no-color plan.out > plan.txt
aws s3 cp plan.out s3://dev-te-testdata/tmp/"${ENV}"/"${TRIGGERING_ACTOR}"/plan.out