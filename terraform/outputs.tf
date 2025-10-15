output "gce_instance_ip" {
  description = "The public IP of the GCE instance"
  value       = module.gce.instance_ip
}

output "cloud_sql_connection_name" {
  description = "The connection name for the Cloud SQL instance"
  value       = module.cloud_sql.instance_connection_name
}
