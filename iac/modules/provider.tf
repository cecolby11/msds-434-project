provider "google" {
  project = var.project_id
  region  = var.project_region
  zone    = var.project_zone
  credentials = file(var.credentials_filepath)
}
