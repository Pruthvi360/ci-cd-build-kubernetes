terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
      credentials = file("service-account.json")
    }
  }

  required_version = ">= 0.14"
}
