resource "google_project_iam_member" "data_transfer" {
  project    = var.project_id
  role   = "roles/iam.serviceAccountShortTermTokenMinter"
  member = "serviceAccount:${google_service_account.bq_scheduled_query.email}"
}
