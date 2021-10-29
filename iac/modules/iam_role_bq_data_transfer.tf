resource "google_project_iam_member" "permissions" {
  role   = "roles/iam.serviceAccountShortTermTokenMinter"
  member = "serviceAccount:${google_service_account.bq_scheduled_query.email}"
}
