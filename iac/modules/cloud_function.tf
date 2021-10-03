locals {
  ingest_zip_withhash = "ingest-${data.archive_file.ingest_code_zip.output_md5}.zip"
  load_zip_withhash   = "load-${data.archive_file.load_code_zip.output_md5}.zip"
}

data "archive_file" "ingest_code_zip" {
  type        = "zip"
  source_dir  = var.cf_ingest_source_dir
  output_path = "${var.cf_etl_output_dir}/ingest.zip"
}

data "archive_file" "load_code_zip" {
  type        = "zip"
  source_dir  = var.cf_load_source_dir
  output_path = "${var.cf_etl_output_dir}/load.zip"
}

resource "google_storage_bucket_object" "ingest_deployment_zip" {
  name   = "${var.cf_etl_output_dir}/${local.ingest_zip_withhash}" # use the zip hash in the name of the bucket object, else google won't notice the code changed 
  bucket = google_storage_bucket.cf_deployment_code.name
  source = "${var.cf_etl_output_dir}/ingest.zip"
}

resource "google_storage_bucket_object" "load_deployment_zip" {
  name   = "${var.cf_etl_output_dir}/${local.load_zip_withhash}" # use the zip hash in the name of the bucket object, else google won't notice the code changed 
  bucket = google_storage_bucket.cf_deployment_code.name
  source = "${var.cf_etl_output_dir}/load.zip"
}


resource "google_cloudfunctions_function" "etl_ingest" {
  name        = "${var.app_name}-ingest-${var.env}"
  description = "Schedule ETL to Ingest data from URL to Bucket"
  runtime     = "nodejs14" # could not change runtime via apply, had to destroy and then recreate the function 

  # https://dev.to/hedlund/scheduled-google-cloud-functions-using-terraform-and-http-triggers-3b8e
  # configure to run as the service account we created
  # instead of default which is the GAE service account 
  service_account_email = google_service_account.etl_ingest.email

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.cf_deployment_code.name
  source_archive_object = google_storage_bucket_object.ingest_deployment_zip.name
  trigger_http          = true
  timeout               = 60
  entry_point           = "ingest"
  labels                = local.labels
  environment_variables = {
    ETL_STORAGE_BUCKET_NAME = google_storage_bucket.csv.name
  }
}

resource "google_cloudfunctions_function" "etl_load" {
  name        = "${var.app_name}-load-${var.env}"
  description = "Triggered off Bucket to Populate data from Bucket to Big Query"
  runtime     = "nodejs14" # could not change runtime via apply, had to destroy and then recreate the function 

  # https://dev.to/hedlund/scheduled-google-cloud-functions-using-terraform-and-http-triggers-3b8e
  # configure to run as the service account we created
  # instead of default which is the GAE service account 
  service_account_email = google_service_account.etl_load.email

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.cf_deployment_code.name
  source_archive_object = google_storage_bucket_object.load_deployment_zip.name
  event_trigger {
    event_type = "google.storage.object.finalize" # every time an object is created
    resource   = google_storage_bucket.csv.id
    failure_policy {
      retry = false
    }
  }
  timeout     = 60
  entry_point = "load"
  labels      = local.labels
  environment_variables = {
    ETL_BQ_DATASET_ID       = google_bigquery_dataset.nyt.dataset_id
    ETL_BQ_TABLE_LOCATION   = google_bigquery_table.nyt.location
    ETL_BQ_TABLE_ID         = google_bigquery_table.nyt.table_id
    ETL_STORAGE_BUCKET_NAME = google_storage_bucket.csv.name
    ETL_BQ_SCHEMA           = google_bigquery_table.nyt.schema
  }
}
