### Prerequisites
- Create a new Project in the console 
  - you can't terraform a project resource without an organization. To create an organization, you have to be a Google Workspace and Cloud Identity customer. Therefore the project should be created in the console and project ID added to the `variables.tf` and `state.tf` in the `{env}` folder. 
- Per project: Create a new service account for Terraform in console before running commands
  - give it the following roles:
    - project editor (to provision resources in the account besides app engine) OR project owner if you want to create a new app engine app (this project does provision app engine)
    - security admin (the set IAM Policy role is used in order to set the service account for the cloud function). 
    - storage object viewer (only if you need to run `terraform init -migrate-state`)
  - create a new key and download it. update the path to the key file on your local machine in `provider.tf`. use an absolute path!
- Per project: Enable the necessary APIs in the console:
  - Note that if you enable the Cloud Resource Manager API in the console then you could terraform the rest of the API enablement used by the project, however API enablement can take a few minutes to propagate and so some resource creation will fail, but there seems to be a bug such that Terraform thinks it's been created and can't create it on the next apply. 
  - Identity and Access Management API (IAM). 
  - Cloud Scheduler API
  - Cloud Storage API
  - App Engine Admin API
  - Cloud Functions API
  - Cloud Build API (gcp uses in cloud function deployment)
  - Resource Manager API
  - Big Query API
  - Big Query Transfer Service (for scheduling big query forecasting)
- Per project: ~~Create a new service account for the CICD tool (CircleCI, GitHub Actions, etc.) in console and give it the following roles:~~ A service account is terraformed for CICD named `cicd-deploy-gae` with the following roles: 
    - storage object admin 
    - service account user 
    - app engine deployer 
    - cloud build service account 
  - create a new key via the console on the service account and download the JSON. save the content as an environment variable/secret in the CICD project (e.g. GitHub secret) to use in the workflow (if you base64 encode it, need to decode it in the workflow before passing it to GOOGLE_CREDENTIALS)
- Per project: Create a new private storage bucket for your account terraform state files, if you would like to use remote state. Configure the bucket name and the absolute path to your credentials file in `state.tf` 


### Build 
```bash
# set the path to the key using the cli's export GOOGLE_APPLICATION_CREDENTIALS="/path/to/json/key/file" 
 environment variable instead of hardcoding it in the provider 
# this enables you to run the terraform the same way whether from github actions workflow, or your command line
# the terraform action uses the variable GOOGLE_CREDENTIALS, because it's passed the actual key contents from the secrets store, instead of the path to the json secrets file which is what GOOGLE_APPLICATION_CREDENTIALS uses .
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/json/key/file" 
# e.g. export GOOGLE_APPLICATION_CREDENTIALS="/users/caseycolby/.ssh/terraform@dev-327916-9fef7acec75a.json" 
cd iac
terraform init
terraform plan
# verify planned changes are as expected
terraform apply
```
