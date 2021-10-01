# populate big query from csv
- generate random csv data for POC and download: https://www.convertcsv.com/generate-test-data.htm
- create new storage bucket for csv files
- upload csv to storage bucket



create service account for terraform with 'project editor' role
terraform:
- cloud storage bucket
- big query table 
- service account for ETL pipeline? 
- cron job? or do I run the cron from github actions? 
