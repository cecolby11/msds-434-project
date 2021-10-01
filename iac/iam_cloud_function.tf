resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.etl.project
  region         = google_cloudfunctions_function.etl.region
  cloud_function = google_cloudfunctions_function.etl.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.etl.email}"
}
