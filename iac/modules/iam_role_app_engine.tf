# resource "google_project_iam_custom_role" "cicd_deploy_app_engine" {
#   role_id     = "CICD_DeployGAE_Permissions"
#   title       = "CICD Custom Role"
#   description = "Permissions for CICD tool to deploy App Engine application code"
#   permissions = [
#     "storage.objects.list",
#     "iam.serviceAccounts.actAs",
#   ]
# }

# per requirements here: https://cloud.google.com/appengine/docs/standard/python/roles
resource "google_project_iam_member" "cicd_appengine" {
  project    = var.project_id
  role       = "roles/appengine.deployer"
  member     = "serviceAccount:${google_service_account.cicd_deploy_gae.email}"
}

resource "google_project_iam_member" "cicd_storage_object" {
  project    = var.project_id
  role       = "roles/storage.objectAdmin"
  member     = "serviceAccount:${google_service_account.cicd_deploy_gae.email}"
}

resource "google_project_iam_member" "cicd_cloud_build" {
  project    = var.project_id
  role       = "roles/cloudbuild.builds.editor"
  member     = "serviceAccount:${google_service_account.cicd_deploy_gae.email}"
}

resource "google_project_iam_member" "cicd_service_account" {
  project    = var.project_id
  role       = "roles/iam.serviceAccountUser"
  member     = "serviceAccount:${google_service_account.cicd_deploy_gae.email}"
}
