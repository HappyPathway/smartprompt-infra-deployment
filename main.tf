terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy to"
  type        = string
  default     = "us-central1"
}

variable "api_environment" {
  description = "Environment variables for the API service"
  type = map(string)
  default = {
    LOG_LEVEL = "INFO"
    ENVIRONMENT = "production"
    WORKERS = "4"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Cloud Run service account
resource "google_service_account" "smartprompt_api" {
  account_id   = "smartprompt-api"
  display_name = "Smart Prompt API Service Account"
}

# Cloud Run service
resource "google_cloud_run_service" "smartprompt_api" {
  name     = "smartprompt-api"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/smartprompt-api:latest"
        ports {
          container_port = 8000
        }
        
        dynamic "env" {
          for_each = var.api_environment
          content {
            name  = env.key
            value = env.value
          }
        }

        resources {
          limits = {
            cpu    = "1000m"
            memory = "512Mi"
          }
        }
      }
      service_account_name = google_service_account.smartprompt_api.email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# IAM binding to make the service public
resource "google_cloud_run_service_iam_member" "public" {
  service  = google_cloud_run_service.smartprompt_api.name
  location = google_cloud_run_service.smartprompt_api.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "service_url" {
  value = google_cloud_run_service.smartprompt_api.status[0].url
}