terraform {
  backend "gcs" {
    bucket      = "tfstate_434_dev"
    prefix      = "project"
  }
}
