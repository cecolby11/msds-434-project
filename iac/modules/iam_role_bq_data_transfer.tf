resource "google_project_iam_member" "data_transfer" {
  project    = var.project_id
  role   = "roles/iam.serviceAccountShortTermTokenMinter"
  member = "serviceAccount:${google_service_account.bq_scheduled_query.email}"
}

resource "google_project_iam_member" "data_transfer_bq_admin" {
  project    = var.project_id
  role   = "roles/bigquery.admin"
  member = "serviceAccount:${google_service_account.bq_scheduled_query.email}"
}
