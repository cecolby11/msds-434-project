module "dev" {
  # globals
  source               = "../modules"
  project_id           = "dev-327916"
  app_name             = "covid_project"
  env                  = "dev"

  # lambdas
  cf_ingest_source_dir   = "../src_ingest"  # App code source directory for cloud function
  cf_load_source_dir = "../src_load"
  cf_etl_output_dir   = "../dist" # Build output dir for the cloud function .zip file
  etl_invoke_schedule = "0 15 * * *"  # daily at 3pm
}
