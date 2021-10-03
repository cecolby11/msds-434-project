resource "google_service_account" "scheduler_invoker" {
  account_id   = "scheduler-invoker-ingest"
  display_name = "Cloud Scheduler Invoker Service Account"
}

resource "google_service_account" "etl_ingest" {
  account_id   = "etl-ingest"
  display_name = "Cloud Function Ingest Service Account"
}

resource "google_service_account" "etl_load" {
  account_id   = "etl-load"
  display_name = "Cloud Function Load Service Account"
}
