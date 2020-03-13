# stack-1

## Prerequirements

Before starting make sure you have the following dependencies installed locally:

- Git (latest version preferred)
- Docker (latest version preferred)

## Assumptions, Disclaimers and Caveats

Before running through the below milestones, there are a few points that should be made:

- This guide assumes you use GitHub as your git service.
- This guide assumes you have a brand new, verified AWS account with not existing resources
or services in use.
- All resources will be deployed to AWS region ap-southeast-2 (Sydney),
unless otherwise modified using the `AWS_DEFAULT_REGION` environment variable.
- Deleting Stack 1 (Milestone 2) using Terraform's `destroy` command will only remove
the S3 bucket if the there are no objects in the bucket.
- All commands and scripts have been constructed wih a Unix shell interpreter (primarily Bash)
in mind. You may be required to tweak each command/step to satisfy your operating environment.

## Milestone 1: Create Deployer IAM Role and Keys

In an ideal world, you would create this user using version control and a CI/CD pipeline.
However, this isn't quite possible for a brand new AWS account. So in this circumstance
we manually create the `deployer` user from within AWS' web console.

1. Create a new IAM user with programmatic access called `deployer` and attach this user
with the following managed policies:

    - `AmazonS3FullAccess`
    - `AmazonDynamoDBFullAccess`
    - `AmazonSSMFullAccess`
    - `AmazonVPCFullAccess`
    - `AmazonEC2FullAccess`

    Be sure to note down the AWS key ID and secret that is generated once the user is
    successfully create.

## Milestone 2: Provision Stack 1 (this repository)

Stack 1 solves a "chicken before the egg" problem that occurs when using Terraform's
[S3 backend type](https://www.terraform.io/docs/backends/types/s3.html).
In order to take advantage of this backend type when performing CI/CD tasks, you need
to have two AWS resources already provisioned: a S3 bucket for storing Terraform state
files; and a DynamoDB table to support state locking when perform Terraform mutations.
But in order to deploy these resources they need to provisioned without the benefits of
CI/CD.

This repo attempts to solve that problem by deploying both a S3 bucket and DynamoDB table
without a CI/CD process. That is, the `terraform apply` command is run locally on the users
machine and the produced Terraform state file is committed to version control.

You could accomplish the same using CloudFormation to provision these resources. However,
for this particular use case there are no secrets in the produced Terraform state file,
so there is no real harm in storing this file in plain text under source control. _Ideally_
your git repository is also not publicly visible.

Follow the below steps on your local machine to deploy Stack 1. Be sure to substitute
`your_aws_access_key_id` and `your_aws_access_key_secret` with the corresponding values
produced in Milestone 1:

```bash
# 1. Fork https://github.com/nicklaw5/stack-1 to your github account.

# 2. Clone stack-1 repository (substitute your_username appropriately)
git clone git@github.com:your_usernme/stack-1.git
cd stack-1

# 3. Remove exisiting Terraform state file
rm terraform/terraform.tfstate

# 4. Set common script environment varaibles (substitute AWS key and secret appropriately)
export TERRAFORM_DIR=terraform
export TERRAFORM_VERSION=0.12.23
export AWS_DEFAULT_REGION=ap-southeast-2
export AWS_ACCESS_KEY_ID=your_aws_access_key_id
export AWS_SECRET_ACCESS_KEY=your_aws_access_key_secret

# 5. Initialise Terraform providers
./scripts/terraform_init.sh

# 6. Validate Terraform configuration
./scripts/terraform_validate.sh

# 7. Generate Terraform plan
./scripts/terraform_plan.sh

# 8. Apply Terrform plan
./scripts/terraform_apply.sh

# 9.Commit Terraform state file (and any other changes)
git commit -am "Updated stack 1"
git push
```

### 3. Stack 2 (this repository)

TODO

### 4. Stack 3 (this repository)

TODO
