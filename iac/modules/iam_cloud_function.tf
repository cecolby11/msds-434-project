resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.etl.project
  region         = google_cloudfunctions_function.etl.region
  cloud_function = google_cloudfunctions_function.etl.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.etl.email}"
}

resource "google_project_iam_custom_role" "cloud_function_etl_operations" {
  role_id     = "CloudFunction_ETL_CustomRole"
  title       = "ETL Custom Role"
  description = "Permissions for operations executed by the Cloud Function ETL's node.js code"
  permissions = ["storage.objects.create"]
}

# resource "google_project_iam_member" "etl" {
#   role   = google_project_iam_custom_role.cloud_function_etl_operations.id
#   member = "serviceAccount:${google_service_account.etl.email}"
# }
