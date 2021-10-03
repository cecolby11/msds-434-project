# NOTE
# App Engine applications cannot be deleted once they're created;
# you have to delete the entire project to delete the application. 
# Terraform will report the application has been successfully deleted;
# this is a limitation of Terraform, and will go away in the future. 
# Terraform is not able to delete App Engine applications.

resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = "us-central"
}
