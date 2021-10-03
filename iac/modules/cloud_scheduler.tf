# cloud scheduler uses app engine cron jobs to run 
resource "google_cloud_scheduler_job" "etl_http_job" {
  name      = "${var.app_name}-invoke-etl-http-${var.env}"
  schedule  = var.etl_invoke_schedule
  time_zone = "America/Chicago"

  http_target {
    uri         = google_cloudfunctions_function.etl_ingest.https_trigger_url
    http_method = "POST"
    body        = base64encode("{\"message\":\"scheduled invocation\"}")
    oidc_token {
      service_account_email = google_service_account.scheduler_invoker.email # needs cloud function invoke permissions on the function 
    }
  }

  retry_config {
    retry_count = 1
  }
}
