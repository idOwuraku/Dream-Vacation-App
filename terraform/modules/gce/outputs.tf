output "instance_ip" {
  description = "The public IP address of the GCE instance"
  value       = google_compute_instance.main.network_interface[0].access_config[0]
}
