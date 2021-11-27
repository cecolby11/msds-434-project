// NOTE: You do not need to include the node_modules folder when you manually upload code as a .zip file—you can successfully deploy your function without the the node_modules folder.

const { BigQuery } = require('@google-cloud/bigquery');
const { Storage } = require('@google-cloud/storage');
const bq = new BigQuery();
const storage = new Storage();

// function to be triggered by cloud storage
// https://cloud.google.com/functions/docs/calling/storage
exports.load = async (file, context) => {
  console.log('Function invoked by Bucket Object Creation');
  console.log(`  Bucket: ${file.bucket}`);
  console.log(`  File: ${file.name}`);
  
  try {
    // Configure the load job per https://github.com/googleapis/nodejs-bigquery/blob/main/samples/loadCSVFromGCS.js
    const metadata = {
      sourceFormat: 'CSV',
      skipLeadingRows: 1, // csv has one header row
      schema: {
        // has to match schema on big query table, but only name and type fields
        fields: JSON.parse(process.env.ETL_BQ_SCHEMA).map(({ name, type }) => ({ name, type })),
      },
      location: process.env.ETL_BQ_TABLE_LOCATION,
    };

    // Load data from a Google Cloud Storage file into the table
    const [job] = await bq
    .dataset(process.env.ETL_BQ_DATASET_ID)
    .table(process.env.ETL_BQ_TABLE_ID)
    .load(storage.bucket(file.bucket).file(file.name), metadata);

    // load() waits for the job to finish
    console.log(`Big Query load job ${job.id} completed.`);

    // Check the job's status for errors
    const errors = job.status.errors;
    if (errors && errors.length > 0) {
      throw errors;
    }

    return 'success';
  } catch (err) {
    console.error('AN ERROR OCCURRED');
    console.error(err);
    return err;
  }
};
