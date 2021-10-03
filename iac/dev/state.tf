terraform {
  backend "gcs" {
    bucket      = "tf_state_msds434"
    prefix      = "dev"
  }
}
