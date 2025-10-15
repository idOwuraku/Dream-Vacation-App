output "instance_connection_name" {
  description = "The connection name of the cloud sql instance"
  value       = google_sql_database_instance.main.connection_name
}
