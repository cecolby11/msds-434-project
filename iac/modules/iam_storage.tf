# grant object creator permissions to service account used by cloud front for bucket
resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.nyt.name
  role = google_project_iam_custom_role.cloud_function_etl_operations.id
  member = "serviceAccount:${google_service_account.etl.email}"
}
