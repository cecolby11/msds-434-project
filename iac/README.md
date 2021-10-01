### Prerequisites
- Create a new service account for Terraform in console before running commands
  - give it project editor, service account user roles, and security admin (or just the set IAM Policy role), which is used in order to set the service account for the cloud function)
  - create a new key and download it. update the path to the key file on your local machine in `provider.tf`. use an absolute path!
- Enable the necessary APIs in the console: 
  - IAM
  - Cloud Scheduler
  - Storage
  - App Engine
  - Cloud Functions

### Build 
```bash
cd iac
terraform init
terraform plan
# verify planned changes are as expected
terraform apply
```
