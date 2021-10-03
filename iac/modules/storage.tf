resource "google_storage_bucket" "cf_deployment_code" {
  name = "${var.app_name}-cloud-function-code-${var.project_id}-${var.env}" # ensure globally unique
}

resource "google_storage_bucket" "nyt" {
  name                        = "latest_nyt_csv-${var.project_id}-${var.env}" # ensure it's unique
  force_destroy               = true # delete files to delete bucket
  location                    = "US"
  uniform_bucket_level_access = true

  labels = local.labels
}
