# TRE Blueprints

* [Introduction](#introduction)
* [OpenID Connect](#openid-connect)
* [GitHub repository configuration](#github-repository-configuration)
* [Terraform IaC configuration](#terraform-iac-configuration)
  * [Manual setup steps for Terraform](#manual-setup-steps-for-terraform)
  * [Terraform Execution](#terraform-execution)
* [Docker Images](#docker-images)
* [Python WHL packages](#python-whl-packages)

# Introduction

A set of blueprints for automating the release of TRE:

* Terraform IaC configuration
* Docker Images
* Software libraries

Separate GitHub repositories can be used to define, build and deploy:

* Terraform environment IaC configuration
  * One repository targeting many AWS environments
  * Pulls in required TRE Terraform modules from separate repositories
* Terraform modules
  * Use one repository per TRE functional area
* Docker images (e.g. for an AWS Lambda function)
  * Use one repository per Docker image
* Software component libraries (e.g. TRE Python event library)
  * Use one repository per library

Having separate GitHub repositories simplifies component versioning.

# OpenID Connect

OpenID Connect must be configured in the target AWS account to allow GitHub
Actions access to AWS.

This allows Actions running Terraform to read and manage AWS resources and
permits other Actions to deploy to AWS services such as CodeArtifact or ECR.

Any GitHub repository with an Action that accesses AWS will need to know the
ARN of the role used to access the OpenID identity provider configured in AWS;
this value (or at least the account number part) will need to be stored in a
Git secret.

# GitHub repository configuration

TRE GitHub repositories with Actions that access AWS will need to have some or
all of the following configured:

* GitHub Environment definitions:
  * A GitHub Environment for each target AWS environment (for Terraform)
  * A GitHub Environment with a list of approvers (for manual approval Jobs)
* GitHub secret definitions:
  * Repository-level GitHub secrets for:
    * The AWS management account access role (for OpenID Connect)
    * The name of the AWS parameter store key that holds Terraform backend settings
    * The webhook URL used for Slack notifications
  * Environment-level GitHub secrets for:
    * The name of the AWS Parameter Store key that holds the environment's
      Terraform variable values
    * The AWS S3 location used for Terraform plan output (to share it across jobs)

> GitHub Environments are configured in the repository under: `Settings ->
  Code and automation -> Environments`

> GitHub environment-level secrets for Actions are configured in the
  repository under: `Settings -> Environments -> ${ENV_NAME} -> Environment secrets`

> GitHub repository-level secrets for Actions are configured in the repository
  under: `Settings -> Security -> Secrets -> Actions -> Repository secrets`

# Terraform IaC configuration

## Manual setup steps for Terraform

The following manual steps are required before Terraform can be run to create
or update an environment:

* Ensure AWS CLI access is configured
* Create a S3 bucket to hold the Terraform state files (one file per env):
  * e.g.: `tre-bp-terraform-state`
* Create a DynamoDB table to hold the Terraform state locks
  * e.g.: `tre-bp-terraform-state`
* Initiate Terraform with `terraform init -backend-config=...` with
  appropriate backend settings file; e.g.:

  ```
  bucket = "tre-bp-terraform-state"
  key = "terraform.tfstate"
  dynamodb_table = "tre-bp-terraform-state"
  encrypt = true
  region = "..."
  ```

* Create required Terraform workspaces; for example, for an environment `dev`:
  * `terraform workspace new dev`

> The above would add file `env:/dev/terraform.tfstate` to the configured
  S3 bucket and `tre-bp-terraform-state/env:/dev/terraform.tfstate-md5`
  to the configured DynamoDB table

## Terraform Execution

The following GitHub Action workflow is a reusable component that shows how to
apply an example Terraform configuration to a target AWS environment:

* [test-terraform-action.yml](.github/workflows/test-terraform-action.yml)

The following GitHub Action workflow reuses the above component to provision
an example Terraform configuration across multiple target AWS environments:

* [.github/workflows/test-terraform-apply.yml](.github/workflows/test-terraform-apply.yml)

# Docker Images

The following example GitHub Action builds, versions and deploys a Docker
image to AWS ECR:

* [poc-lambda-ecr-deploy.yml](.github/workflows/poc-lambda-ecr-deploy.yml)

The above action calls the following composite GitHub Action examples:

* [get-next-version](.github/actions/get-next-version/action.yml)
* [docker-build-and-deploy-to-ecr](.github/actions/docker-build-and-deploy-to-ecr/action.yml)

# Python WHL packages

The following example GitHub Action demonstrates how to build and deploy a
Python wheel package to AWS CodeArtifact:

* [test-codeartifact-main.yml](.github/workflows/test-codeartifact-main.yml)
