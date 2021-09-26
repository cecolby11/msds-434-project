# msds-434-project
[![cecolby11](https://circleci.com/gh/cecolby11/msds-434-project.svg?style=shield&circle-token=521d5ab299a5ba339ebaa449aa01b386bfd49585)](https://circleci.com/gh/cecolby11/msds-434-project)

## Directory Structure
```
web_service/        # Source Code for Python Web Application
│   __init__.py     # Python file for namespacing package so it can be imported
│   main.py         # Json service entry point - app engine expects this to be named main
│   hello.py        # simple python function for demoing circleci project 
│   app.yaml        # Configuration for web service deployment to App Engine
└───tbd             # GCP service implementations for BigQuery etc.? 
.circleci/          # CircleCI configuration files for CICD
└───config.yaml     # CircleCI workflow configuration 
tests/              # Python application test suite 
docs/               # Documentation/Notes
Makefile            # Defines build tasks such as tests, linting, etc. 
requirements.txt    # Lists dependencies required for the python application code
.gitignore          # Lists files that should not be tracked
.editorconfig       # Configuration for code editors
```

## Setup to run locally 
```bash
# Python comes installed with the venv module 
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
make all
```

## Run Flask API locally 
```bash
python web_service/main.py
```
