terraform {
  backend "gcs" {
    bucket      = "tf_state_msds434"
    prefix      = "project"
    credentials = "/users/caseycolby/.ssh/terraform@local-cedar-327215-43b157a3e5c7.json"
  }
}
