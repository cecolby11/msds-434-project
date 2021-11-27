# MDSD 434 MVP: Covid-19 Forecast API on GCP 
![Infra Actions Status](https://github.com/cecolby11/msds-434-project/actions/workflows/build_infra.yml/badge.svg)
![Hello World API Actions Status](https://github.com/cecolby11/msds-434-project/actions/workflows/deploy_hello_app.yml/badge.svg)
![BQ Covid19 API Actions Status](https://github.com/cecolby11/msds-434-project/actions/workflows/deploy_covid19_app.yml/badge.svg)

## Project Background

My work as a university developer on Covid-19 related infrastructure and applications in the last year provided the inspiration for this project topic.

Sophisticated dashboards and predictions with machine learning are widely available on the web. These solutions help organizations respond to Covid-19 by examining trends such as cases by county or country, or by providing targeted solutions such as special event planning. 

The university would also benefit from deploy its own targeted solutions and models with internal data sources in order to better support its response to constantly evolving conditions. For example, understanding the impact of seasonal trends throughout the academic year such as the effect on case counts of beginning a new school year or returning from holiday breaks is critical in order to inform policy decisions around testing, masking, and remote learning. Furthermore, the university needs the ability to examine these trends across university-specific groups such as undergraduate students, graduate students, faculty, and staff. 

The university's Covid-19 dashboard reports on descriptive weekly statistics such as case counts, however as the pandemic continues to evolve and the organization accumulates more historical Covid-19 data it becomes imperative to incorporate predictive solutions into its response. 

## Project Description

This project creates an API that publishes forecasts of the cumulative number of Covid-19 cases by state. 

The initial model was built using publicly available Covid-19 data for US states, in order to move to development quickly within the limited timeline. This MVP allows for the university to deploy all of the necessary data engineering infrastructure into the organization and easily iterate on the current model to model the internal university case data by group. Further iterations of the solution can incorporate additional API endpoints and UI/visualization.  

## API Documentation

View the Open API Spec for the Covid-19 service:

[View Raw YAML](./docs/open_api/covid19.yaml)

Load the yaml content into https://editor.swagger.io/ to view in the swagger interface.

## Deploying
Deploying to Google Cloud is automated with GitHub Actions. 

There are three workflows defined in GitHub Actions: 
- One to provision the GCP infrastructure from the terraform IaC files. This pipeline runs when changes are made to the IaC directory or the ETL source code directories.
- One to deploy the application code for the hello world API to Google App Engine. This pipeline runs when changes are made to the gae_web_service directory.
- One to deploy the application code for the Covid-19 API to Google App Engine. This pipeline runs when changes are made to the gae_covid19 directory.

The project currently has two environments: dev and prod. The dev environment is deployed when changes are pushed to the dev branch in GitHub; the prod environment is deployed when changes are pushed to the main branch in GitHub. You can also manually deploy any of the workflows from the 'Actions' tab in the GitHub repository. 

## Architecture/Design

![Architecture Diagram](./docs/MSDS-434-project.drawio.png?raw=true "Architecture Diagram")

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
gae_covid19                 # App Code for API to serve BigQuery Predictions (Node.js/Express)
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
└───deploy_covid19_app.yaml # GHA workflow configuration to deploy BigQuery Covid-19 app to GAE
iac/                        # Terraform Infrastructure-as-Code configuration files
│   <env>/                  # Per-environment Terraform variables, outputs, and state configuration
└───modules/                # Terraform modules, used by all environments
src_etl_ingest/             # Node.js application code for the ETL's Cloud Function to Ingest data into GCP from an endpoint
src_etl_load/               # Node.js application code for the ETL's Cloud Function to Load data from GCP storage to BigQuery
docs/                       # Documentation
.gitignore                  # Lists files that should not be tracked
.terraform-version          # Configures terraform version for tfenv utility to install
.editorconfig               # Configuration for code editors
```

## Running the Project Locally
Follow the documentation to install the Google Cloud SDK if you haven't already, to set up the gcloud command-line tool: https://cloud.google.com/sdk

### Running the Node.js application code locally 
Navigate to the 'service accounts' section of the GCP IAM console. Create a new JSON key and download the `App Engine default service account` JSON key to your local machine from GCP. Google App Engine uses a default service account named <PROJECT_ID>@appspot.gserviceaccount.com. 

Set the credentials: set the path to the key by setting the CLI GOOGLE_APPLICATION_CREDENTIALS variable with the path to the json key file on your machine. This enables you to run the code the same way Google App Engine would, from your command line. 
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/json/key/file" 
```

Navigate to the node.js directory, install dependencies, then r node.js and pass the name of the entry file: 
```bash
cd gae_covid19
npm install
node app.js
``` 

Visit `localhost:8080` in your browser. 

### Terraforming locally 
Navigate to the 'service accounts' section of the GCP IAM console. Create a new JSON key for the `terraform` service account and download the JSON key to your local machine from GCP.

Set the credentials: set the path to the key by setting the CLI GOOGLE_APPLICATION_CREDENTIALS variable with the path to the json key file on your machine. This enables you to run the terraform the same way the GitHub Actions workflow would, from your command line. 
```bash
# set the path to the key using the cli's export GOOGLE_APPLICATION_CREDENTIALS="/path/to/json/key/file" environment variable
# e.g. export GOOGLE_APPLICATION_CREDENTIALS="/users/caseycolby/.ssh/terraform@dev-327916-9fef7acec75a.json" 
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/json/key/file" 
```

Navigate to the directory for the environment you want to deploy (e.g. dev) and run terraform commands 
```bash
cd iac/dev
terraform init # initialize the necessary providers and remote state
terraform plan # to view planned changes and verify they are as expected, without applying them 
terraform apply # to execute changes 
```

### Running the Flask Hello World API locally 
This project also includes a hello world API to play around with. This is a great starting point if you are new to API development, CICD, or Google App Engine.

Setup: navigate to the directory and install dependencies
```bash
# Python comes installed with the venv module 
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
make all
```

Run the Flask API 
```bash
cd gae_web_service
python main.py
```

Visit localhost:8080 in your browser.

## Setting up a new environment in GCP[^1]
- Within the `iac` directory, duplicate an existing terraform environment directory and rename it for your environment. 
- Create a new project in the GCP console for the new environment. Add the project ID to the `iac/{env}/variables.tf` in the `iac/{env}` directory. [^2]
- Per project: Via the GCP storage console, create a new private storage bucket for your account terraform state files. Update the bucket name in `iac/{env}/state.tf`. 
- Per project: Create a new `terraform` service account for Terraform via the GCP IAM console before running commands. Give it the following roles:

  | Role | Purpose | 
  | --- | --- | 
  | Project Owner [^3] | To provision a new App Engine application. |
  | Roles Administrator | To create other IAM Roles | 
  | Security Admin | The set IAM Policy role is used in order to set the service account for the cloud function. |
  | Storage Object Viewer | Needed only if you need to run `terraform init -migrate-state`. |
  | Service Account User | In order to create the BigQuery data transfer config with a service account, the account calling the API needs to be able to impersonate the service account because it must be created with the same service account that will be invoking it. |
- Per project: Enable the necessary APIs in the console [^4]
  - Identity and Access Management (IAM) API
  - Cloud Scheduler API
  - Cloud Storage API
  - App Engine Admin API
  - Cloud Functions API
  - Cloud Build API (used by GCP to deploy cloud functions)
  - Resource Manager API
  - BigQuery API
  - BigQuery Transfer Service (for scheduling BigQuery forecasting)
  - Stackdriver Monitoring API 

### Setting up CICD Permissions and Workflows
- Create a new job in each CICD workflow .yml in the `.github/workflows` directory specific to the new environment 
- Via the service accounts section of the GCP IAM console, create a new JSON key on the `terraform` service account in your environment and download it. Add the key to the GitHub repository secrets for use in CICD. 
- Run the Infra CICD pipeline to provision the infrastructure.
- A new service account will be terraformed by the infra build with the permissions for deploying code to App Engine. The service account is named `cicd-deploy-gae` with the following roles: 
    - Storage Object Admin 
    - Service Account User
    - App Engine Admin[^5]
    - Cloud Build Service Account
  - Once you have run the infra build create a new JSON key on the `CICD` service account via the service account section of the GCP IAM console. Download the JSON key and add it as an environment secret in GitHub repository secrets to use in the GitHub Actions workflow. Use secret name: `GCLOUD_KEY_${ENV}`. 

## Secure Application Checklist
### Principle of Least Privilege 
Separate service accounts were created for the purposes below scoped only to the roles needed for the action
- provisioning resources for Terraform IaC
- CICD deploying application code to Google App Engine
- Running the scheduled job in BigQuery to generate predictions
- Invoking the Extract Cloud Function on a cron via Cloud Scheduler 
- Executing the Extract Cloud Function 
- Executing the Load Cloud Function

### Multiple Environments
Separate environments are created for development and production with separate credentials and identical configuration.

### No credentials committed to version control 
The GCP Service Account Key is stored in the GitHub repository's secrets for use in the GitHub Actions workflows

### Sanitize Inputs
Use the BigQuery Node.js library's [query parameters syntax](https://cloud.google.com/bigquery/docs/parameterized-queries#bigquery-query-params-nodejs) when the query includes user inputs (such as state name) in order to protect against SQL injection attacks. 

### Handle Errors Gracefully
Catch errors and handle, to avoid returning any sensitive information. 

### Future Security Implementation
-  [ ] Enforce HTTPS on Google App Engine endpoints
-  [ ] Scope service account permissions down further to individual permissions in custom roles instead of using predefined GCP roles. 
-  [ ] API Authentication

[^1]: In the future, this should be scripted; time did not allow in the scope of this project.
[^2]: You can't terraform a project resource without an organization so this could not be terraformed for this project since to create an organization, you have to be a Google Workspace and Cloud Identity customer. If you are a Google Workspace and Cloud Identity customer and have a GCP organization, you could update the IaC to terraform the project, otherwise the project should be created via the console until this section can be scripted. 
[^3]: The project owner permission is required because the project provisions a new app engine application, and you must have owner permissions to do this if you are using the predefined roles. In the future, we should define custom roles and scope the permissions down more than the predefined roles; time did not allow for this in the scope of this project. 
[^4]: Note that if you enable the Cloud Resource Manager API in the console then you could terraform the rest of the API enablement used by the project, however API enablement can take a few minutes to propagate and so some resource creation will fail, but there seems to be a bug such that Terraform thinks it's been created and can't create it on the next apply, becoming stuck in this catch-22. Therefore, it is preferable not to terraform these.
[^5]: Contrary to the documentation, App Engine Deployer errors due to insufficient permissions.
