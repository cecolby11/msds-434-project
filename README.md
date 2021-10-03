# msds-434-project
![example workflow Actions Status](https://github.com/cecolby11/msds-434-project/actions/workflows/app.yml/badge.svg)

## Directory Structure
```
main.py         # Json service entry point - app engine expects this to be named main
app.yaml        # Configuration for web service deployment to App Engine
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
cd gae_web_service
python main.py
```
