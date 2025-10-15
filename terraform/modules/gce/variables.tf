variable "project_id" {
  description = "The GCP zone for the GCE instance"
  type        = string
  default     = "dream-vacations-server"
}

variable "zone" {
  description = "The GCP zone for the GCE instance"
  type        = string
}

variable "instance_name" {
  description = "The name of the GCE instance"
  type        = string
  default     = "dream-vacations-server"
}



variable "db_password_secret_id" {
  description = "THe full ID of the Secret Manager secret for the DB password"
  type        = string
}

variable "ssh_public_key" {
  description = "The public SSH key for accessing the instance"
  type        = string
}

