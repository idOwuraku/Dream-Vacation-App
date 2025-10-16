terraform {
  backend "gcs" {
    bucket  = "oao-terraform-state"
    prefix  = "terraform/state"
  }
}