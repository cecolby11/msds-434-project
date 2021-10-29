# create/replace model 
# see tf documentation note queries with DML language must specify create_disposition = "" and write_disposition = ""
# without that will not get tf error but will get job error about "Cannot set create disposition in jobs with ML DDL statements" 
# can view error in console > Query History (bottom of big query console) > Project History
# to solve this, need the equivalent of checking the box in the console for "Save query results in a temporary table", aka adding those two properties
resource "google_bigquery_job" "create_model" {
  job_id = "create_model_us_cases_by_state_5"

  labels = local.labels

  query {
    query = file("${path.module}/bq_ml_forecast_us_cases/bq_create_model.sql")
    use_legacy_sql = false
    create_disposition = ""
    write_disposition = ""

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
