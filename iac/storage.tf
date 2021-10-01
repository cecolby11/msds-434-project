resource "google_storage_bucket" "nyt" {
  name                        = "latest_nyt_csv"
  force_destroy               = true # delete files to delete bucket
  location                    = "US"
  uniform_bucket_level_access = true

  labels = {
    env = "default"
    terraform = true
  }
}
