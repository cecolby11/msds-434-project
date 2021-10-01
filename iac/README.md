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
- Create a new private storage bucket for your account terraform state files, if you would like to use remote state. Configure the bucket name and the absolute path to your credentials file in `state.tf`.

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
