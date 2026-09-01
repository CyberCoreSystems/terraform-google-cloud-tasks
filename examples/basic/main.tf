terraform {
  required_version = ">= 1.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.0, < 8.0"
    }
  }
}

provider "google" {
  project = "iacbazaar-example-project"
  region  = "us-central1"
}

module "jobs" {
  source = "../../"

  project_id = "iacbazaar-example-project"
  name       = "example-jobs"
  location   = "us-central1"

  max_dispatches_per_second = 50
  max_concurrent_dispatches = 20
  max_attempts              = 10
}

output "queue_id" {
  value = module.jobs.id
}
