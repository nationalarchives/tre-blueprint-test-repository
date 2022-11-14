# TRE Blueprints

GitHub action blueprints for automating the release of:

* Terraform IaC configuration
* Docker Images
* Python WHL packages

# Terraform IaC configuration

# Docker Images

The following example GitHub Action builds, versions (by incrementing the
latest Git tag patch version) and deploys a Docker image to AWS ECR:

* [poc-lambda-ecr-deploy.yml](.github/workflows/poc-lambda-ecr-deploy.yml)

The above action calls the following composite GitHub Action examples:

* [get-next-version](.github/actions/get-next-version/action.yml)
* [docker-build-and-deploy-to-ecr](.github/actions/docker-build-and-deploy-to-ecr/action.yml)

Each Docker image should have its own GitHub repository so it can be versioned
independently to other components.

# Python WHL packages
