variable "project_id" {
  description = "The project id"
  type        = string
}

variable "region" {
  description = "The GCP region for the cloud sql instance"
  type        = string
}

variable "db_instance_name" {
  description = "The name of the cloud sql instance"
  type        = string
  default     = "dream-vacations-db"
}

variable "db_user_name" {
  description = "The username for the database application user"
  type        = string
  default     = "dev"
}

variable "db_password_secret_id" {
  description = "the full id of the secret manager secret for the db password"
  type        = string
}

variable "db_password" {
  description = "The password for the database user."
  type        = string
  sensitive   = true
}
