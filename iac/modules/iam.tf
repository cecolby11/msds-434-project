resource "google_service_account" "etl" {
  account_id   = "bq-etl"
  display_name = "Big Query ETL Service Account"
}
