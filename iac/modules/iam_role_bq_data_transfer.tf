resource "google_project_iam_member" "data_transfer" {
  role   = "roles/iam.serviceAccountShortTermTokenMinter"
  member = "serviceAccount:${google_service_account.bq_scheduled_query.email}"
}
