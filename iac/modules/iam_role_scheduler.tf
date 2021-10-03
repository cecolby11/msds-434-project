# scheduler needs cloudfunctions.invoker on the cloudfunctions to invoke it 
resource "google_cloudfunctions_function_iam_member" "ingest_invoker" {
  project        = google_cloudfunctions_function.etl_ingest.project
  region         = google_cloudfunctions_function.etl_ingest.region
  cloud_function = google_cloudfunctions_function.etl_ingest.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.scheduler_invoker.email}"
}
