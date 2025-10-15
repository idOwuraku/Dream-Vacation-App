output "secret_id" {
  description = "The full ID of the Secret Manager secret."
  value       = google_secret_manager_secret.db_password.id
}

output "secret_value" {
  description = "The value of the secret."
  value       = google_secret_manager_secret_version.db_password_initial_version.secret_data
  sensitive   = true
}