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
resource "google_project_iam_member" "cicd_appengine_deployer" {
  project    = var.project_id
  role       = "roles/appengine.deployer"
  member     = "serviceAccount:${google_service_account.cicd_deploy_gae.email}"
}

# Deployer not enough, contrary to documentation. Error you get is:
# Your deployment has succeeded, but promoting the new version to default failed. You may not have permissions to change traffic splits. Changing traffic splits requires the Owner, Editor, App Engine Admin, or App Engine Service Admin role. 
resource "google_project_iam_member" "cicd_appengine_admin" {
  project    = var.project_id
  role       = "roles/appengine.appAdmin"
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
