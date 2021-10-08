# PERMISSIONS FOR INGEST

# storage.objects.create needed on the BUCKET for the ingest

resource "google_project_iam_custom_role" "ingest_storage_operations" {
  role_id     = "CloudFunction_Ingest_Storage_Permissions"
  title       = "ETL Custom Role"
  description = "Permissions for operations executed by CF Ingest node.js code"
  permissions = [
    "storage.objects.create",
  ]
}

# grant object creator permissions to service account used by cloud front for bucket
resource "google_storage_bucket_iam_member" "ingest" {
  bucket = google_storage_bucket.csv.name
  role   = google_project_iam_custom_role.ingest_storage_operations.id
  member = "serviceAccount:${google_service_account.etl_ingest.email}"
}

# PERMISSIONS FOR LOAD

# bigquery.jobs.create is required on the PROJECT for the load
# bigquery.tables.create is needed on the DATASET for the load 
# bigquery.tables.updateData needed on the TABLE for the load
# storage.objects.get needed on the BUCKET for the load 


resource "google_project_iam_custom_role" "load_project_permissions" {
  role_id     = "CloudFunction_Load_Project_Permissions"
  title       = "ETL Custom Role"
  description = "Permissions for operations executed by CF Load node.js code"
  permissions = [
    "bigquery.jobs.create",
  ]
}

resource "google_project_iam_custom_role" "load_dataset_permissions" {
  role_id     = "CloudFunction_Load_BQ_Dataset_Permissions"
  title       = "ETL Custom Role"
  description = "Permissions for operations executed by CF Load node.js code"
  permissions = [
    "bigquery.tables.create",
  ]
}

resource "google_project_iam_custom_role" "load_table_permissions" {
  role_id     = "CloudFunction_Load_BQ_Table_Permissions"
  title       = "ETL Custom Role"
  description = "Permissions for operations executed by CF Load node.js code"
  permissions = [
    "bigquery.tables.updateData",
  ]
}

resource "google_project_iam_custom_role" "load_storage_operations" {
  role_id     = "CloudFunction_Load_Storage_Permissions"
  title       = "ETL Custom Role"
  description = "Permissions for operations executed by CF Ingest node.js code"
  permissions = [
    "storage.objects.get",
  ]
}

resource "google_bigquery_table_iam_member" "load" {
  project    = google_bigquery_table.nyt_states.project
  dataset_id = google_bigquery_table.nyt_states.dataset_id
  table_id   = google_bigquery_table.nyt_states.table_id
  # role = "roles/bigquery.dataOwner"
  role   = google_project_iam_custom_role.load_table_permissions.id
  member = "serviceAccount:${google_service_account.etl_load.email}"
}

resource "google_bigquery_dataset_iam_member" "load" {
  project    = google_bigquery_table.nyt_states.project
  dataset_id = google_bigquery_table.nyt_states.dataset_id
  role       = google_project_iam_custom_role.load_dataset_permissions.id
  member     = "serviceAccount:${google_service_account.etl_load.email}"
}

resource "google_project_iam_member" "load" {
  project = google_bigquery_table.nyt_states.project
  role    = google_project_iam_custom_role.load_project_permissions.id
  member  = "serviceAccount:${google_service_account.etl_load.email}" # bigquery.jobs.create is required on the PROJECT
}

# grant object creator permissions to service account used by cloud front for bucket
resource "google_storage_bucket_iam_member" "load" {
  bucket = google_storage_bucket.csv.name
  role   = google_project_iam_custom_role.load_storage_operations.id
  member = "serviceAccount:${google_service_account.etl_load.email}"
}
 
