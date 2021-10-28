terraform {
  backend "gcs" {
    bucket      = "tfstate_434_prod"
    prefix      = "project"
  }
}
