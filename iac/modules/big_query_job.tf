# create/replace model 
resource "google_bigquery_job" "create_model" {
  job_id = "forecast_us_cases_create_model"

  labels = local.labels

  query {
    query = file("${path.module}/bq_ml_forecast_us_cases/bq_create_model.sql")
  }
}

# # generate predictions from model 
# creating this via big_query_data_transfer config instead in order to schedule it 
# resource "google_bigquery_job" "predict_from_model" {
#   job_id = "forecast_us_cases_predict_from_model"

#   labels = local.labels

#   query {
#     query = file("${path.module}/bq_ml_forecast_us_cases/bq_forecast_from_model.sql")
#   }
# }
