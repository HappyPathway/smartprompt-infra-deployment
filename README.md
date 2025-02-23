# tf-smart-prompt

Repository for the gcp-kubernetes project in HappyPathway

## Getting Started

1. Clone this repository:
```bash
git clone git@github.com:HappyPathway/tf-smart-prompt.git
cd tf-smart-prompt
```

2. Set up Python environment and install dependencies:
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows use: .venv\Scripts\activate
pip install -r scripts/requirements.txt
```

3. Run the initialization script:
```bash
python scripts/init.py
```

This will:
- Verify Git SSH access to GitHub
- Create the workspace directory structure
- Clone or update all project repositories
- Set up repository configurations

For debugging, you can run:
```bash
python scripts/init.py --debug
```

## Repository Structure

This project consists of multiple repositories:

- terraform-provider-smartprompt: tf-smart-prompt::terraform-provider-smartprompt
- smartprompt-api: tf-smart-prompt::smartprompt-api
- smartprompt-client: tf-smart-prompt::smartprompt-client
- smartprompt-infra-deployment: tf-smart-prompt::smartprompt-infra-deployment

## Development Environment

This repository includes:
- VS Code workspace configuration
- GitHub Copilot settings
- Project-specific documentation and guidelines
- Python-based initialization tools

## Contributing

Please see the [CONTRIBUTING.md](.github/CONTRIBUTING.md) file for guidelines.

# Smart Prompt Infrastructure Deployment

This repository contains the Terraform configurations to deploy the Smart Prompt API to Google Cloud Platform using Cloud Run.

## Prerequisites

1. Google Cloud Platform account with billing enabled
2. Google Cloud SDK installed and configured
3. Terraform installed
4. Docker installed (for building the container image)

## Deployment

1. Initialize Terraform:
```bash
terraform init
```

2. Create a terraform.tfvars file with your GCP project ID:
```hcl
project_id = "your-project-id"
region     = "us-central1"  # Optional, defaults to us-central1
```

3. Build and push the Docker image:
```bash
gcloud auth configure-docker
docker build -t gcr.io/your-project-id/smartprompt-api:latest ../smartprompt-api/
docker push gcr.io/your-project-id/smartprompt-api:latest
```

4. Deploy the infrastructure:
```bash
terraform apply
```

The Cloud Run service URL will be output at the end of the deployment.

## Infrastructure Components

- Cloud Run service for the API
- Service account for the Cloud Run service
- IAM configuration for public access to the API

## Cleanup

To remove all created resources:
```bash
terraform destroy