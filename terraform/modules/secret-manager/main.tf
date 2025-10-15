resource "google_secret_manager_secret" "db_password" {
  project   = var.project_id
  secret_id = var.secret_name

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_initial_version" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.initial_db_password

  lifecycle {
    ignore_changes = [secret_data]
  }
}



