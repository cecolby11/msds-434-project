# Globals
variable "project_id" {}
variable  "project_region" {
    default = "us-central1"
}
variable "project_zone" {
    default = "us-central1-a"
}
variable "credentials_filepath" {}
variable "app_name" {}
variable "env" {}

# Lambda
variable "cf_etl_source_dir" {}
variable "cf_etl_output_path" {}
variable "cf_etl_entry_point" {}
