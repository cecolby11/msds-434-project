module "dev" {
  # globals
  source               = "../modules"
  project_id           = "dev-327916"
  app_name             = "msds434_covid19"
  env                  = "dev"

  # lambdas
  cf_ingest_source_dir   = "../../src_etl_ingest"  # App code source directory for cloud function
  cf_load_source_dir = "../../src_etl_load" # App code source directory for cloud function
  cf_etl_output_dir   = "../dist" # Build output dir for the cloud function .zip file
  etl_invoke_schedule = "0 15 * * *"  # daily at 3pm
}
