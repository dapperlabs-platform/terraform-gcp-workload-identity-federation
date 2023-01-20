terraform {
  required_version = "> 1.0.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "> 3.88.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "> 3.87.0"
    }
  }
}
