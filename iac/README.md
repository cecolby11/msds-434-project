### Prerequisites
- Create a new Project in the console 
  - you can't terraform a project resource without an organization. To create an organization, you have to be a Google Workspace and Cloud Identity customer. Therefore the project should be created in the console and project ID added to the `variables.tf` and `state.tf` in the `{env}` folder. 
- Per project: Enable the necessary APIs in the console: 
  - Identity and Access Management API (IAM)
  - Cloud Scheduler API
  - Cloud Storage API
  - App Engine Admin API
  - Cloud Functions API
  - Cloud Build API (gcp uses in cloud function deployment)
- Per project: Create a new service account for Terraform in console before running commands
  - give it the following roles:
    - project editor (to provision resources in the account besides app engine) OR project owner if you want to create a new app engine app (this project does provision app engine)
    - security admin (the set IAM Policy role is used in order to set the service account for the cloud function). 
    - storage object viewer (only if you need to run `terraform init -migrate-state`)
  - create a new key and download it. update the path to the key file on your local machine in `provider.tf`. use an absolute path!
- Per project: Create a new service account for the CICD tool (CircleCI, GitHub Actions, etc.) in console 
  - give it the following roles:
    - app engine admin  (to provision resources in the account)
    - storage object admin 
    - storage admin 
    - service account user 
    - app engine deployer 
    - cloud build service account 
  - create a new key and download it. save it as an environment variable/secret in your CICD project to use in the workflow
- Per account: Create a new private storage bucket for your account terraform state files, if you would like to use remote state. Configure the bucket name and the absolute path to your credentials file in `state.tf`, if you are creating a new envivronment, update the 'prefix' in the `state.tf` file to save your environment's state at a new path in the existing bucket. 

### Build 
```bash
cd iac
terraform init
terraform plan
# verify planned changes are as expected
terraform apply
```


## TODO 
- import the GAE application into the terraform state and manage it with terraform - that would solve the problem of creating it before starting the circle ci app deploy to update it with the code. 
