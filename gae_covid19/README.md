To run this web service locally:
```bash
cd gae_covid19
npm install

export GOOGLE_APPLICATION_CREDENTIALS="/path/to/json/key/file/with/access/to/account" 
# e.g. export GOOGLE_APPLICATION_CREDENTIALS="/users/caseycolby/.ssh/terraform@dev-327916-9fef7acec75a.json" 

npm run start:local # starts a local development server
```
