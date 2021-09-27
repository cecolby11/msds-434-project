## Creating a Python API and running it locally
- add flask to requirements.txt and install 
- in web service directory for default API, create `main.py`, write the Flask API implementation in here 
  - Google Cloud Documentation offers a good [Hello World tutorial](https://cloud.google.com/appengine/docs/standard/python3/building-app/writing-web-service) and the sample code was helpful for building my first flask API 


## Google App Engine
- Each GCP project can only have one GAE application. The first service deployed is the default. 
- You can have multiple services in your GAE App, but each is a separate directory in your project, has its own app.yaml in its directory, and is deployed separately by running the command from within that directory. 
- Flask is commonly used for creating APIs in python, but webapp2 is slightly easier to use and comes out-of-the-box on GAE instead of having to import and set it up. I'm going to go with Flask because I would still need to setup the dependencies locally for local development, and I prefer using what I see more examples/usage of, and designing independently of GCP. 
- GAE expects the API entry point to be in main.py

## Setting up GCP App Engine Deploy with CircleCI
1. create a service account in GCP console 
   1. add app engine admin role 
   2. add storage object admin role
   3. add storage admin role
   4. add service account user role
   5. (alternatively for development purposes, just add project editor role to get all permissions needed)
   6. also note if you change the permissions/roles, you have to wait a few minutes for them to take effect it seems.
2. create key and download as json 
   1. click the three dots next to the service account in the list and click 'manage keys'
   2. click 'add key' > 'create new key' button 
   3. select json. private key will be downloaded to your local machine. 
3. set the credential up in circle ci as an environment variable : 
   1. in circleci console > project dashboard > click the settings button on the top-right 
   2. click 'add environment variable'
   3. add one for GOOGLE_PROJECT_ID
   4. add one for GOOGLE_COMPUTE_ZONE and GOOGLE_COMPUTE_REGION (REGION us-central1, ZONE us-central1-a	)
   5. add one for GCLOUD_SERVICE_KEY
      1.  base64 encode the json you downloaded so it can be pasted into circleci: in terminal on your machine, run `cat path/to/your/credentials.json | base64 | pbcopy`
      2.  pbcopy puts it in your clipboard so you can go to circleci and past it in as the value 
      3.  jk ended up just pasting in the json as-is and putting it in a json file as a step in the job and it worked! 
4. enable app engine APIs on the google cloud project to deploy with gcloud app deploy, and enable compute APIs to set default zone with set compute/zone command
5. Create a new GAE app in the console or command line (you can only use CD to deploy to an existing app, not to conditionally create one if it's not there)
6. you don't need the install dependencies stage in the gcloud app deploy pipeline, it installs them from requirements.txt it seems. 

https://localghost.dev/2019/12/deploying-your-google-appengine-app-with-circleci/


