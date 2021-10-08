// NOTE: You do not need to include the node_modules folder when you manually upload code as a .zip file—you can successfully deploy your function without the the node_modules folder.
const express = require('express');
const bq = require('./apis/gcp_big_query');

// Create an Express object and routes (in order)
const app = express();

app.get('/', (req, res) => {
    res.send(`<h4>Welcome</h4>
    <p>Visit /api/v1/{your state name}/cumulative/forecast 
    to see the forecasted number of cumulative cases for your state`
    )
});

app.get('/api/v1/:state/cumulative/forecast', async (req, res) => {
    try {
        const results = await bq.forecastCumulativeCases(req.params.state);
        res.json(results);
    } catch (err) {
        res.send('An error occurred, please retry your request or contact an administrator');
    }
});


// Start the server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
  console.log('Press Ctrl+C to quit.');
});

module.exports = app;
