resource "google_sql_database_instance" "main" {
  project          = var.project_id
  name             = var.db_instance_name
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
    }
  }

  deletion_protection = false
}

resource "google_sql_user" "dev" {
  project  = var.project_id
  instance = google_sql_database_instance.main.name
  name     = var.db_user_name
  password = var.db_password
}

