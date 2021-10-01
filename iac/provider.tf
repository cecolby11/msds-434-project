provider "google" {
  project = "local-cedar-327215"
  region  = "us-central1"
  zone    = "us-central1-a"
  credentials = file("/users/caseycolby/.ssh/terraform@local-cedar-327215-43b157a3e5c7.json")
}
