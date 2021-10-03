// NOTE: You do not need to include the node_modules folder when you manually upload code as a .zip file—you can successfully deploy your function without the the node_modules folder.

const axios = require('axios');
const fs = require('fs');
const {Storage} = require('@google-cloud/storage');

// Creates a client
const storage = new Storage();

const bucketName = process.env.ETL_STORAGE_BUCKET_NAME;
const tmpFileName = '/tmp/us.csv'; // use cloud fxn writeable /tmp directory 

exports.handler = async (req, res) => {
  try {
    console.log('hello');
    // use axios to download the latest day of data from NYT GitHub 
    const url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us.csv'; // us for initial development because counties quite large
    const axiosResponse = await axios.get(url, { responseType: 'stream' });
    axiosResponse.data.pipe(fs.createWriteStream(tmpFileName));
    // drop it in storage bucket
    const storageResponse = await storage.bucket(bucketName).upload(tmpFileName, {
      destination: `us-${Date.now()}.csv`,
    });
    res.send('success');
  } catch (err) {
    console.error('AN ERROR OCCURRED');
    console.error(err);
    res.send(err);
  }

  // drop it in storage bucket
  // import it from storage to big query
  // alternatively could have a trigger on the bucket that automatically invokes a separate job to put it in big query  
};
