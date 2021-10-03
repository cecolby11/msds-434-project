output "project_id" {
    value = var.project_id
}

output "project_region" {
    value = var.project_region
}

output "project_zone" {
    value = var.project_zone
}

output "app_engine_id" {
  value = google_app_engine_application.app.id
}

output "app_engine_app_id" {
    value = google_app_engine_application.app.app_id
}
