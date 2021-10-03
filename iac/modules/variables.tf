# Globals
variable "project_id" {}
variable  "project_region" {
    default = "us-central1"
}
variable "project_zone" {
    default = "us-central1-a"
}
variable "app_name" {}
variable "env" {}

# Lambda
variable "cf_ingest_source_dir" {}
variable "cf_load_source_dir" {}
variable "cf_etl_output_dir" {}
variable "etl_invoke_schedule" {}
