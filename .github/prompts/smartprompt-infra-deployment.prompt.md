Develop Terraform code to deploy the FastAPI prompt-refinement API to Google Cloud Platform. The deployment should have the following characteristics:

- Use a service such as Google Cloud Run (or App Engine) for deploying a containerized FastAPI application.
- Include a Dockerfile for building the FastAPI application container image.
- Define Terraform resources to:
  - Build and push the Docker image to Google Container Registry (GCR) or Artifact Registry.
  - Deploy the container to Cloud Run (or App Engine) with appropriate configuration for scaling, memory allocation, and environment variables.
  - Set up any necessary IAM roles and service accounts to allow Cloud Run to pull the image and operate securely.
  - Configure a domain or URL endpoint for accessing the API.
- Include configuration for managing environment-specific variables (e.g., project ID, region, service name).
- Ensure that the Terraform code is modular and well-documented, with instructions on how to deploy, update, and tear down the infrastructure.

Your Terraform configuration should follow best practices for GCP deployments, enabling continuous integration and deployment pipelines.
