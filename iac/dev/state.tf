terraform {
  backend "gcs" {
    bucket      = "tf_state_msds434"
    prefix      = "dev"
    # credentials = "/users/caseycolby/.ssh/terraform@local-cedar-327215-43b157a3e5c7.json"
    credentials = "/users/caseycolby/.ssh/terraform@msds-434-dev-3f00f7b5c048.json"
  }
}
