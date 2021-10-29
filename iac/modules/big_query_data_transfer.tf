# schedule query to run the prediction-generation every friday and save to big query 
resource "google_bigquery_data_transfer_config" "query_config" {
  depends_on = [google_project_iam_member.data_transfer]

  display_name         = "Generate Weekly Forecasts of Covid Cumulative Cases by State"
  location             = "US"
  data_source_id       = "scheduled_query"
  service_account_name = google_service_account.bq_scheduled_query.name
  schedule             = "every sunday 00:00"
  destination_dataset_id = google_bigquery_dataset.nyt.dataset_id
  params = {
    destination_table_name_template = google_bigquery_table.weekly_forecast_by_state.table_id
    write_disposition               = "WRITE_TRUNCATE" # vs WRITE_APPEND
    query                           = file("${path.module}/bq_ml_forecast_us_cases/bq_forecast_from_model.sql")
  }
}
