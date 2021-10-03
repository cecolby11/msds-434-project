module "dev" {
  # globals
  source   = "../modules"
  # project_id = "local-cedar-327215"
  project_id = "msds-434-dev"
  # credentials_filepath = "/users/caseycolby/.ssh/terraform@local-cedar-327215-43b157a3e5c7.json"
  credentials_filepath = "/users/caseycolby/.ssh/terraform@msds-434-dev-3f00f7b5c048.json"
  app_name = "covid_project"
  env      = "dev"

  # lambdas
  cf_etl_source_dir  = "../etl_src"  # App code source directory for cloud function
  cf_etl_output_path = "../etl_dist/index.zip" # Build output for the cloud function .zip file
  cf_etl_entry_point = "handler"
}
