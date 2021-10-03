module "dev" {
  # globals
  source   = "../modules"
  project_id = "dev-327916"
  credentials_filepath = "/users/caseycolby/.ssh/terraform@dev-327916-9fef7acec75a.json"
  app_name = "covid_project"
  env      = "dev"

  # lambdas
  cf_etl_source_dir  = "../etl_src"  # App code source directory for cloud function
  cf_etl_output_path = "../etl_dist/index.zip" # Build output for the cloud function .zip file
  cf_etl_entry_point = "handler"
}
