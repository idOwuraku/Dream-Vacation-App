variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "secret_name" {
  description = "secrets to create"
  type        = string
  default     = "db-password"
}

variable "initial_db_password" {
  description = "The inital passowrd for the database user"
  type = string
  sensitive = true
}