resource "google_storage_bucket" "deployment_code" {
  name = "bigquery-cron-cloud-function-code"
}

data "archive_file" "datahub_zip" {
  type        = "zip"
  source_dir  = "etl_src"
  output_path = "etl_dist/index.zip"
}
resource "google_storage_bucket_object" "deployment_zip" {
  name   = "index.zip"
  bucket = google_storage_bucket.deployment_code.name
  source = "etl_dist/index.zip"
}

resource "google_cloudfunctions_function" "etl" {
  name        = "nyt-bigquery-etl"
  description = "Schedule ETL to Populate Big Query Table"
  #   runtime     = "nodejs14"
  runtime = "python39"

  # https://dev.to/hedlund/scheduled-google-cloud-functions-using-terraform-and-http-triggers-3b8e
  # configure to run as the service account we created
  # instead of default which is the GAE service account 
  service_account_email = google_service_account.etl.email

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.deployment_code.name
  source_archive_object = google_storage_bucket_object.deployment_zip.name
  trigger_http          = true
  timeout               = 60
  entry_point           = "handler"
  labels = {
    env       = "default"
    terraform = true
  }

  #   environment_variables = {
  #     MY_ENV_VAR = "my-env-var-value"
  #   }
}
