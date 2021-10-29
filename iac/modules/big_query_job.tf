resource "google_bigquery_job" "create_model" {
  job_id = "forecast_us_cases_create_model"

  labels = local.labels

  query {
    query = file("${path.module}/bq_ml_forecast_us_cases/bq_create_model.sql")
  }
}
