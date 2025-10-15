variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "the GCP region for resources"
  type        = string
  default     = "africa-south1"
}

variable "zone" {
  description = "GCP zone for the GCE instance"
  type        = string
  default     = "africa-south1-a"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "initial_db_password" {
  description = "The initial password for the database user. This should be set in a local terraform.tfvars file."
  type        = string
  sensitive   = true
}