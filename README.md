# msds-434-project
![Infra Actions Status](https://github.com/cecolby11/msds-434-project/actions/workflows/build_infra_dev.yml/badge.svg)
![Hello World API Actions Status](https://github.com/cecolby11/msds-434-project/actions/workflows/deploy_app_dev.yml/badge.svg)
![BQ Covid19 API Actions Status](https://github.com/cecolby11/msds-434-project/actions/workflows/deploy_covid19_app.yml/badge.svg)

## Directory Structure
```
gae_web_service             # App Code for Hello World JSON API (Python/Flask)
│   main.py                 # JSON Hello World API entry point - App Engine python runtime expects this to be named main
│   tests/                  # Python application test suite 
│   requirements_dev.txt    # Lists dependencies required for developing the python application code
│   requirements.txt        # Lists dependencies required for the production python application
│   Makefile                # Defines build tasks such as tests, linting, etc. 
│   app.yaml                # Configuration for web service deployment to App Engine
└───.gcloudignore           # Lists files in the enclosing directory that should not be deployed to App Engine 
gae_covid19                 # App Code for API to serve Big Query Predictions (Node.js/Express)
│   app.js                  # Node/Express API entry point - App Engine node runtime expects this to be named main
│   apis/                   # Python application test suite 
│   .env.example            # Example environment variables file that can be committed to source control 
│   package.json            # Lists dependencies required for the node application
│   package-lock.json       # Auto-generated file to track versions of dependencies
│   app.yaml                # Configuration for web service deployment to App Engine
└───.gcloudignore           # Lists files in the enclosing directory that should not be deployed to App Engine 
.github/workflows/          # GitHub Actions configuration files for CICD
│   build_infra_dev.yaml    # GHA workflow configuration to build application infrastructure (Terraform IaC files)
│   deploy_app_dev.yaml     # GHA workflow configuration to deploy Hello World app to GAE
└───deploy_covid19_app.yaml # GHA workflow configuration to deploy Big Query Covid app to GAE
iac/                        # Terraform Infrastructure-as-Code configuration files
docs/                       # Documentation/Notes
.gitignore                  # Lists files that should not be tracked
.terraform-version          # Configures terraform version for tfenv utility to install
.editorconfig               # Configuration for code editors
```

## Running the Flask Hello World API locally 
### Setup
```bash
# Python comes installed with the venv module 
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
make all
```

### Run Flask API 
```bash
cd gae_web_service
python main.py
```

## GCP setup for deploying a new environment
- Create a new Project in the console for you new environment
  - you can't terraform a project resource without an organization. To create an organization, you have to be a Google Workspace and Cloud Identity customer. Therefore the project should be created via the console and project ID added to the `variables.tf` and `state.tf` in the `{env}` folder. 
- Per project: Create a new private storage bucket for your account terraform state files. Configure the bucket name and the absolute path to your credentials file in `state.tf` 
- Per project: Create a new service account for Terraform in console before running commands. Give it the following roles:
    - project owner (because the project provisions a new app engine application, and you must have owner permissions if you are using the predefined roles - if we were to go from MVP to operationalizing this, would probably want to define custom roles and scope the permissions down as much as possible).
    - Roles Administrator to create other IAM Roles
    - security admin (the set IAM Policy role is used in order to set the service account for the cloud function). 
    - storage object viewer (only if you need to run `terraform init -migrate-state`)
  - create a new JSON key on the service account and download it. Add the key to the GitHub repository secrets for use in  CICD. 
- Per project: Enable the necessary APIs in the console:
  - Note that if you enable the Cloud Resource Manager API in the console then you could terraform the rest of the API enablement used by the project, however API enablement can take a few minutes to propagate and so some resource creation will fail, but there seems to be a bug such that Terraform thinks it's been created and can't create it on the next apply. Therefore I'm doing it via the console. 
  - Identity and Access Management API (IAM). 
  - Cloud Scheduler API
  - Cloud Storage API
  - App Engine Admin API
  - Cloud Functions API
  - Cloud Build API (gcp uses in cloud function deployment)
  - Resource Manager API
  - Big Query API
  - Big Query Transfer Service (for scheduling big query forecasting)
- Per project: ~Create service account~ A new service account will be terraformed in the infra build for the CICD GAE deployments of the app code, named `cicd-deploy-gae` with the following roles: 
    - storage object admin 
    - service account user 
    - app engine admin (deployer not enough and errors due to permissions, contrary to the documentation) 
    - cloud build service account 
  - create a new key via the console on the service account and download the JSON. save the content as an environment variable/secret in the CICD project (e.g. GitHub secret) to use in the workflow (if you base64 encode it, need to decode it in the workflow before passing it to GOOGLE_CREDENTIALS)

### Terraforming locally 
If you are running any of the terraform locally, notes about setting credentials. 
```bash
# set the path to the key using the cli's export GOOGLE_APPLICATION_CREDENTIALS="/path/to/json/key/file" environment variable instead of hardcoding it in the provider 
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
