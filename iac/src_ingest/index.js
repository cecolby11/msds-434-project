// NOTE: You do not need to include the node_modules folder when you manually upload code as a .zip file—you can successfully deploy your function without the the node_modules folder.

const axios = require('axios');
const fs = require('fs');
const { Storage } = require('@google-cloud/storage');

// Creates a client
const storage = new Storage();

const bucketName = process.env.ETL_STORAGE_BUCKET_NAME;
const tmpFileName = '/tmp/us-states.csv'; // use cloud fxn writeable /tmp directory 

exports.ingest = async (req, res) => {
  try {
    console.log('function invoked by HTTP');
    // use axios to download the latest day of data from NYT GitHub 
    const url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us-states.csv';
    const axiosResponse = await axios.get(url, { responseType: 'stream' });
    axiosResponse.data.pipe(fs.createWriteStream(tmpFileName));
    // drop it in storage bucket
    // request and response format: https://googleapis.dev/nodejs/storage/latest/Bucket.html#upload
    const storageResponse = await storage.bucket(bucketName).upload(tmpFileName, {
      destination: `us-states-${Date.now()}.csv`,
    });
    console.log(`CREATED STORAGE OBJECT WITH ID: ${storageResponse[1].id}`);
    res.send(storageResponse[1].id);
  } catch (err) {
    console.error('AN ERROR OCCURRED');
    console.error(err);
    res.send(err);
  }
};
