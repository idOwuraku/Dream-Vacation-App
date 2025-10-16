provider "google" {
  project = var.project_id
  region  = var.region
}

module "secret_manager" {
  source              = "./modules/secret-manager"
  project_id          = var.project_id
  initial_db_password = var.initial_db_password
}

module "cloud_sql" {
  source                = "./modules/cloud-sql"
  project_id            = var.project_id
  region                = var.region
  db_password_secret_id = module.secret_manager.secret_id
  db_password           = module.secret_manager.secret_value
}

module "gce" {
  source                = "./modules/gce"
  project_id            = var.project_id
  zone                  = var.zone
  db_password_secret_id = module.secret_manager.secret_id
  ssh_public_key        = file(var.ssh_public_key_path)
}
