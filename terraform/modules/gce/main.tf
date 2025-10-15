resource "google_service_account" "gce_sa" {
  account_id   = "gce-container-runner"
  display_name = "Service account for GCE Container Runn"
}

resource "google_project_iam_member" "gcr_pull" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gce_sa.email}"
}

resource "google_secret_manager_secret_iam_member" "secret_accessor" {
  project   = var.project_id
  secret_id = var.db_password_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.gce_sa.email}"
}

resource "google_compute_instance" "main" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = "e2-micro"
  zone         = var.zone
  tags         = ["http-server", "https-server", "allow-ssh"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = google_service_account.gce_sa.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    ssh-keys = "apps-user:${var.ssh_public_key}"
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    systemctl start docker
  EOT
}

resource "google_compute_firewall" "allow_http" {
  name          = "allow-http"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http-server"]
}

resource "google_compute_firewall" "allow_https" {
  name          = "allow-https"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["https-server"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}
