# cloud scheduler uses app engine cron jobs to run 
resource "google_cloud_scheduler_job" "hello_http_job" {
  name      = "etl-invoke-fxn-http-job-${var.env}"
  schedule  = "0 15 * * *" # daily at 3pm
  time_zone = "America/Chicago"

  http_target {
    uri         = google_cloudfunctions_function.etl.https_trigger_url
    http_method = "POST"
    body        = base64encode("{\"name\":\"scheduler\"}")
    oidc_token {
      service_account_email = google_service_account.etl.email
    }
  }

  retry_config {
    retry_count = 1
  }
}
